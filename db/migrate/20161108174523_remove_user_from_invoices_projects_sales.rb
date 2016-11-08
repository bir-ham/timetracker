class RemoveUserFromInvoicesProjectsSales < ActiveRecord::Migration
  def change
    remove_column :sales, :user_id
    remove_column :projects, :user_id
    remove_column :invoices, :user_id
  end
end
