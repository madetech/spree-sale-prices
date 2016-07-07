describe Spree::LineItem do
  context '.pre_sale_price' do
    let(:order) { create(:order) }
    let(:default_price) { create(:pre_sale_price, amount: 50, currency: 'USD') }
    let(:another_price) { create(:pre_sale_price, amount: 100, currency: 'USD') }
    let(:variant) { create(:variant, pre_sale_prices: [default_price]) }
    let(:variant_without_pre_sale_price) { create(:variant) }
    let(:line_item_with_pre_sale_price) do
      line_item = create(:line_item, variant: variant,
                         pre_sale_price: variant.pre_sale_price_in('USD'))
    end

    it 'adds the pre-sale price from the variant pre-sale price when creating' do
      line_item = order.line_items.create(quantity: 1,
                                          variant: variant)
      expect(line_item.pre_sale_price).to eq(50.00)
    end

    it 'does not set the pre-sale price if it has already been set' do
      line_item = order.line_items.create(quantity: 1,
                                          variant: variant)

      variant.pre_sale_prices = [another_price]
      line_item.variant = variant
      line_item.save

      expect(line_item.pre_sale_price).to eq(50.00)
    end

    it 'ignores the pre-sale price if the variant does not have one' do
      line_item = order.line_items.create(quantity: 1,
                                          variant: variant_without_pre_sale_price)
      expect(line_item.pre_sale_price).to be_nil
    end
  end
end
