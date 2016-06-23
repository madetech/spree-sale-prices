require 'spec_helper'

describe Spree::Product do
  let(:gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
  let(:variant) { create(:variant, pre_sale_prices: [gbp_price]) }
  let(:product) { create(:product, master: variant) }

  context '.pre_sale_price_in' do
    it 'returns the pre-sale price for the master variant' do
      expect(product.pre_sale_price_in('GBP').amount.to_s).to eq('200.0')
    end
  end
end
