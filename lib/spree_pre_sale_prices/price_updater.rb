module PreSalePrices
  class PriceUpdater
    def initialize(variant)
      @variant = variant
    end

    def update_prices(prices)
      prices.each do |currency, new_price|
        price = variant.price_in(currency)
        price.amount = new_price
        price.save!
      end
    end

    def update_pre_sale_prices(prices)
      prices.each do |currency, new_price|
        pre_sale_price = variant.pre_sale_price_in(currency)
        pre_sale_price.amount = new_price
        pre_sale_price.save!
      end
    end

    private

    attr_reader :variant
  end
end
