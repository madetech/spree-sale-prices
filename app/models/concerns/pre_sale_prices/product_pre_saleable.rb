module PreSalePrices
  module ProductPreSaleable
    extend ActiveSupport::Concern

    included do
      has_many :pre_sale_prices, -> do
        order('spree_variants.position,
               spree_variants.id,
               currency')
      end, through: :variants

      delegate :pre_sale_price_in, to: :master
    end

    def on_sale?
      pre_sale_prices.count > 0
    end
  end
end
