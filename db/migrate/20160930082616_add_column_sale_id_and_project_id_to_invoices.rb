class AddColumnSaleIdAndProjectIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :sale_id, :integer
    add_column :invoices, :project_id, :integer
  end
end
