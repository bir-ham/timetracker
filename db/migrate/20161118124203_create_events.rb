class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :date_range
      t.date :start
      t.date :end
      t.string :color

      t.timestamps null: false
    end
  end
end
