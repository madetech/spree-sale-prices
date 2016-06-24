describe PreSalePrices::PriceUpdater do
  let(:variant) { create(:variant) }
  let(:new_prices) { { 'GBP' => '100.0', 'USD' => '200.0' } }
  let(:zero_price) { { 'GBP' => '0.0' } }

  context '.update_prices' do
    it 'updates the prices of the variant to match the price hash' do
      described_class.new(variant).update_prices(new_prices)

      variant.prices.reload

      expect(variant.price_in('GBP').amount.to_s).to eq(new_prices['GBP'])
      expect(variant.price_in('USD').amount.to_s).to eq(new_prices['USD'])
    end
  end

  context '.update_pre_sale_prices' do
    it 'updates the pre-sale prices of the variant to match the price hash' do
      described_class.new(variant).update_pre_sale_prices(new_prices)

      variant.pre_sale_prices.reload

      expect(variant.pre_sale_price_in('GBP').amount.to_s).to eq(new_prices['GBP'])
      expect(variant.pre_sale_price_in('USD').amount.to_s).to eq(new_prices['USD'])
    end

    it 'ignores zero prices' do
      described_class.new(variant).update_pre_sale_prices(zero_price)

      variant.pre_sale_prices.reload

      expect(variant.pre_sale_prices).to be_empty
    end
  end
end
