module PreSalePrices
  module VariantPreSaleable
    extend ActiveSupport::Concern

    included do
      has_many :pre_sale_prices,
               class_name: 'Spree::PreSalePrice',
               dependent: :destroy,
               inverse_of: :variant

      def pre_sale_price_in(currency)
        pre_sale_prices.find { |price| price.currency == currency } ||
          Spree::PreSalePrice.new(variant_id: id, currency: currency, amount: 0)
      end
    end
  end
end
