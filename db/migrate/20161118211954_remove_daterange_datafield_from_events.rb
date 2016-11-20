class RemoveDaterangeDatafieldFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date_range
  end
end
