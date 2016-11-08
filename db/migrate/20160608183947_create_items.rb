class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.date :date
      t.integer :quantity
      t.string :unit
      t.decimal :unit_price
      t.integer :vat
      t.integer :sale_id

      t.timestamps null: false
    end
  end
end
