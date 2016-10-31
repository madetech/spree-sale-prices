module PreSalePrices
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_pre_sale_prices'

    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Spree::Variant.class_eval do
        has_many :pre_sale_prices,
                 class_name: 'Spree::PreSalePrice',
                 dependent: :destroy,
                 inverse_of: :variant

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

      #Spree::Variant.include(::PreSalePrices::VariantPreSaleable)
      #Spree::Product.include(::PreSalePrices::ProductPreSaleable)

      Spree::Product.class_eval do
        has_many :pre_sale_prices, through: :variants_including_master

        delegate :pre_sale_price_in, to: :master
        delegate :pre_sale_price, to: :master

        def on_sale?(currency)
          pre_sale_prices.in_currency(currency).sum(:amount) > 0
        end
      end

      #Spree::LineItem.include(::PreSalePrices::LineItemPreSaleable)
      Spree::LineItem.class_eval do
        before_validation :copy_pre_sale_price

        attr_accessible :quantity, :variant

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

      #Spree::Admin::PricesController.include(::PreSalePrices::AdminPricesPreSaleable)
      Spree::Admin::PricesController.class_eval do
        def create
          create_or_update_prices

          flash[:success] = Spree.t('notice.prices_saved')
          redirect_to admin_product_path(parent)
        end

        private

        def create_or_update_prices
          params[:prices].each do |variant_id, prices|
            variant = Spree::Variant.find(variant_id)
            PreSalePrices::PriceUpdater.new(variant).update_prices(prices)
          end

          params[:pre_sale_prices].each do |variant_id, prices|
            variant = Spree::Variant.find(variant_id)
            PreSalePrices::PriceUpdater.new(variant).update_pre_sale_prices(prices)
          end
        end
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
