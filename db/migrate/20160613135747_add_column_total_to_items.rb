class AddColumnTotalToItems < ActiveRecord::Migration
  def change
    add_column :items, :total, :decimal
  end
end
