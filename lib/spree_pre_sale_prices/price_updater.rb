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

    private

    attr_reader :variant
  end
end
