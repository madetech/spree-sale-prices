describe Spree::PreSalePrice do
  let(:price) { 100 }

  context '.money' do
    subject { described_class.new(price: price).money.to_s }

    it { is_expected.to eq('$100.00') }
  end
end
