class DropUnitPriceFromInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoice_items, :unit_price
    add_column :invoice_items, :unit_price, :decimal
  end
end
