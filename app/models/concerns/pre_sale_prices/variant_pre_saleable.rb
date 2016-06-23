module PreSalePrices
  module VariantPreSaleable
    extend ActiveSupport::Concern

    included do
      has_many :pre_sale_prices,
               class_name: 'Spree::PreSalePrice',
               dependent: :destroy,
               inverse_of: :variant
    end
  end
end
