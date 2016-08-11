class ChangeDataFieldStringToTextInContacts < ActiveRecord::Migration
  def up
    change_column :contacts, :message, :text 
  end
  def down
    change_column :contacts, :message, :string 
  end
end
