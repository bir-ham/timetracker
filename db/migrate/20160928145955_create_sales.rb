class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :customer_id
      t.integer :user_id
      t.date :date
      t.string :status
      t.text :description

      t.timestamps null: false
    end
  end
end
