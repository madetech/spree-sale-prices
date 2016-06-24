module PreSalePrices
  module AdminPricesPreSaleable
    extend ActiveSupport::Concern

    included do
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
end
