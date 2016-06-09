class AddColumnCustomerIdToInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :customer, :string
    add_column :invoices, :customer_id, :integer
  end
end
