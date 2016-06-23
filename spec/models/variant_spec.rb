require 'spec_helper'
require 'ffaker'

describe Spree::Variant do
  let(:usd_price) { create(:pre_sale_price, amount: 100, currency: 'USD') }
  let(:gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
  let(:variant) { create(:variant, pre_sale_prices: [usd_price, gbp_price]) }

  context '.pre_sale_price_in' do
    it 'returns the price in the provided currency' do
      expect(variant.pre_sale_price_in('GBP').amount.to_s).to eq('200.00')
    end
  end
end
