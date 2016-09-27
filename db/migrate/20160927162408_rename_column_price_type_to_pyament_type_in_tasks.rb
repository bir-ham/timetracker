class RenameColumnPriceTypeToPyamentTypeInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :price_type, :payment_type
  end
end
