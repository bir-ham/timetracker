class RemoveColumnCustomerIdInInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :customer_id
  end
end
