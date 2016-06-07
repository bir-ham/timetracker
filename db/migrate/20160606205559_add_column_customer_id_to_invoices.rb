class AddColumnCustomerIdToInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :customer, :string
    remove_column :invoices, :customer_id, :integer
    add_column :invoices, :customer_id, :integer
  end
end
