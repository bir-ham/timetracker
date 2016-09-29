class RemoveDateDatafieldInItems < ActiveRecord::Migration
  def change
    remove_column :items, :date
  end
end
