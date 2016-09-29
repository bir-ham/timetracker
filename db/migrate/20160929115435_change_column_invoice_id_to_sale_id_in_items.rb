class ChangeColumnInvoiceIdToSaleIdInItems < ActiveRecord::Migration
  def change
    rename_column :items, :invoice_id, :sale_id
  end
end
