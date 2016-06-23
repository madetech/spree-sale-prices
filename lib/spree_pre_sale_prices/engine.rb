module PreSalePrices
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_pre_sale_prices'

    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Spree::Variant.include(::PreSalePrices::VariantPreSaleable)
      Spree::Product.include(::PreSalePrices::ProductPreSaleable)
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
