describe SpreePreSalePrices do
  context 'VERSION' do
    it 'shows the current version' do
      expect(described_class::VERSION).to eq('1.0.0')
    end
  end
end
