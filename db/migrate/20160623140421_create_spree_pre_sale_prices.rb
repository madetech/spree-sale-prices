class CreateSpreePreSalePrices < ActiveRecord::Migration
  def change
    create_table :spree_pre_sale_prices do |t|
      t.belongs_to :variant
      t.decimal    :amount, precision: 8, scale: 2, default: 0
      t.string     :currency
      t.datetime   :deleted_at
    end

    add_index 'spree_pre_sale_prices', ['deleted_at'],
              name: 'index_spree_pre_sale_prices_on_deleted_at', using: :btree
    add_index 'spree_pre_sale_prices', %w(variant_id currency),
              name: 'index_spree_pre_sale_prices_on_variant_id_and_currency', using: :btree
  end
end
