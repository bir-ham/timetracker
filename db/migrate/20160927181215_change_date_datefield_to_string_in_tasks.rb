class ChangeDateDatefieldToStringInTasks < ActiveRecord::Migration
  def up
    change_column :tasks, :hours, :string
  end
  def down
    change_column :tasks, :hours, :date
  end
end
