class AddColumnTotalToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :total, :decimal
  end
end
