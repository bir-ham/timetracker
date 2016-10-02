class RemoveColumnInvoiceIdInSales < ActiveRecord::Migration
  def change
    remove_column :sales, :invoice_id
  end
end
