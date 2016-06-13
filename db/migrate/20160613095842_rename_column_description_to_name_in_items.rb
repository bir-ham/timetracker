class RenameColumnDescriptionToNameInItems < ActiveRecord::Migration
  def change
    rename_column :items, :description, :name 
  end
end
