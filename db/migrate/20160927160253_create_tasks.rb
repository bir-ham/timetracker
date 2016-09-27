class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :date
      t.string :price_type
      t.decimal :price
      t.integer :vat

      t.timestamps null: false
    end
  end
end
