module PreSalePrices
  module LineItemPreSaleable
    extend ActiveSupport::Concern

    included do
      before_validation :copy_pre_sale_price
    end

    def pre_sale_price_money
      Spree::Money.new(pre_sale_price, { currency: currency })
    end

    def copy_pre_sale_price
      if variant && !pre_sale_price_set?
        update_pre_sale_price
      end
    end

    def update_pre_sale_price
      variant_pre_sale_price = variant.pre_sale_price_in(variant.currency).amount

      if variant_pre_sale_price.present? and variant_pre_sale_price > 0
        self.pre_sale_price = variant_pre_sale_price
      else
        self.pre_sale_price = nil
      end
    end

    def pre_sale_price_set?
      self.pre_sale_price.present? && self.pre_sale_price > 0
    end
  end
end
