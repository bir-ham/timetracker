class AddColumnInoiceIdToSales < ActiveRecord::Migration
  def change
    add_column :sales, :invoice_id, :integer
  end
end
