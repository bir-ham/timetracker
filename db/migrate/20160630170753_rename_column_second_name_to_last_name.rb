class RenameColumnSecondNameToLastName < ActiveRecord::Migration
  def change
    rename_column :users, :second_name, :last_name
  end
end
