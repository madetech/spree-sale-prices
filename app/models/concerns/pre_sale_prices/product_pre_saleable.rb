module PreSalePrices
  module ProductPreSaleable
    extend ActiveSupport::Concern

    included do
      has_many :pre_sale_prices, -> do
        order('spree_variants.position,
               spree_variants.id,
               currency')
      end, through: :variants_including_master

      delegate :pre_sale_price_in, to: :master
      delegate :pre_sale_price, to: :master
    end

    def on_sale?(currency)
      pre_sale_prices.in_currency(currency).sum(:amount) > 0
    end
  end
end
