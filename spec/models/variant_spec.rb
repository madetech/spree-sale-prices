require 'spec_helper'

describe Spree::Variant do
  let(:gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
  let(:variant) { create(:variant, pre_sale_prices: [gbp_price]) }

  context '.pre_sale_price_in' do
    it 'returns the price in the provided currency' do
      expect(variant.pre_sale_price_in('GBP').amount.to_s).to eq('200.0')
    end
  end
end
