describe Spree::Product do
  context 'when product on sale' do
    let(:gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
    let(:on_sale_variant) { create(:variant, pre_sale_prices: [gbp_price]) }
    let(:another_on_sale_variant) { create(:variant, pre_sale_prices: [gbp_price]) }

    let(:on_sale_product) do
      create(:product, master: on_sale_variant,
             variants: [another_on_sale_variant])
    end

    it 'should be on sale' do
      expect(on_sale_product.on_sale?('GBP')).to be_truthy
    end

    it 'should return the pre-sale price for the master variant' do
      expect(on_sale_product.pre_sale_price_in('GBP').amount.to_s).to eq('200.0')
    end
  end

  context 'when product not on sale' do
    let(:not_on_sale_product) { create(:product) }

    it 'should not be on sale' do
      expect(not_on_sale_product.on_sale?('GBP')).to be_falsy
    end
  end

  context 'when the pre-sale price is zero in GBP' do
    let(:zero_gbp_price) { create(:pre_sale_price, amount: 0, currency: 'GBP') }
    let(:variant_with_zero_pre_sale_price) { create(:variant, pre_sale_prices: [zero_gbp_price]) }
    let(:product_with_zero_presale_price) { create(:product, master: variant_with_zero_pre_sale_price) }

    subject { product_with_zero_presale_price.on_sale?('GBP') }

    it { is_expected.to be(false) }
  end

  context 'when only some currencies are on sale' do
    let(:zero_eur_price) { create(:pre_sale_price, amount: 0, currency: 'EUR') }
    let(:two_hundred_gbp_price) { create(:pre_sale_price, amount: 200, currency: 'GBP') }
    let(:variant_with_eur_pre_sale_price) { create(:variant, pre_sale_prices: [two_hundred_gbp_price, zero_eur_price]) }
    let(:product_with_multiple_currency_prices) { create(:product, master: variant_with_eur_pre_sale_price) }

    subject { product_with_multiple_currency_prices }

    it 'should not be on sale in EUR' do
      expect(subject.on_sale?('EUR')).to be(false)
    end

    it 'should be on sale in GBP' do
      expect(subject.on_sale?('GBP')).to be(true)
    end
  end
end
