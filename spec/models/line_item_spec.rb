describe Spree::LineItem do
  context '.pre_sale_price' do
    let(:line_item) { create(:line_item, pre_sale_price: 200.99) }

    it 'returns the pre-sale price if one was set' do
      expect(line_item.pre_sale_price).to eq(200.99)
    end
  end
end
