class ChangeColumnCompanyToCustomer < ActiveRecord::Migration
  def change
  	rename_column :invoices, :company, :customer
  end
end
