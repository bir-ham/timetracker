class ChangeColumnNameDateToHoursInTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :date, :hours
  end

end
