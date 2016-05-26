class ChangeInterestonarrearsToInterestinarrears < ActiveRecord::Migration
  def change
    rename_column :invoices, :interest_on_arrears, :interest_in_arrears
  end
end
