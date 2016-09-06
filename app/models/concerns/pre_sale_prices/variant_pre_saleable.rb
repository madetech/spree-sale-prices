module PreSalePrices
  module VariantPreSaleable
    extend ActiveSupport::Concern

    included do
      has_many :pre_sale_prices,
               class_name: 'Spree::PreSalePrice',
               dependent: :destroy,
               inverse_of: :variant
    end

    def pre_sale_price_in(currency)
      pre_sale_prices.find { |price| price.currency == currency } ||
        Spree::PreSalePrice.new(variant_id: id, currency: currency, amount: 0)
    end

    def display_pre_sale_price_in(currency)
      pre_sale_price_in(currency).display_price
    end

    def pre_sale_price
      pre_sale_prices.find { |price| price.currency == Spree::Config[:currency] }
    end
  end
end
