class AddPreSalePriceToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :pre_sale_price, :decimal, precision: 8, scale: 2, default: 0
  end
end
