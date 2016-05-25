class ChangePhonenumberDatefieldInCustomers < ActiveRecord::Migration
   def up
    change_column :customers, :phone_number, :string
  end
  def down
    change_column :customers, :phone_number, :integer
  end
end
