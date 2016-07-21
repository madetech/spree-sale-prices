describe Spree::PreSalePrice do
  let(:price) { 100 }

  context '.money' do
    subject { described_class.new(price: price).money.to_s }

    it { is_expected.to eq('$100.00') }
  end

  context '.to_s' do
    it 'nicely formats price value' do
      pre_sale_price = described_class.new(price: price)
      expect(pre_sale_price.to_s).to eq('100.00')
    end

    it 'handles nil price value' do
      pre_sale_price = described_class.new(price: nil)
      expect(pre_sale_price.to_s).to eq('')
    end
  end
end

