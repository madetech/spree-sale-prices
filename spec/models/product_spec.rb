describe Spree::Product do
  let(:gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
  let(:on_sale_variant) { create(:variant, pre_sale_prices: [gbp_price]) }
  let(:another_on_sale_variant) { create(:variant, pre_sale_prices: [gbp_price]) }
  let(:not_on_sale_product) { create(:product) }
  let(:on_sale_product) do
    create(:product, master: on_sale_variant,
                     variants: [another_on_sale_variant])
  end

  context '.pre_sale_price_in' do
    it 'returns the pre-sale price for the master variant' do
      expect(on_sale_product.pre_sale_price_in('GBP').amount.to_s).to eq('200.0')
    end
  end

  context '.on_sale?' do
    it 'returns true if the product has any pre-sale prices set' do
      expect(on_sale_product.on_sale?).to be_truthy
      expect(not_on_sale_product.on_sale?).to be_falsy
    end
  end
end
