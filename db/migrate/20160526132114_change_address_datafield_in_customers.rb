class ChangeAddressDatafieldInCustomers < ActiveRecord::Migration
   def up
    change_column :customers, :address, :text
  end
  def down
    change_column :customers, :address, :string
  end
end
