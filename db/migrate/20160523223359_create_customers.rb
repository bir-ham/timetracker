class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :phone_number
      t.string :email
      t.string :address

      t.timestamps null: false
    end
  end
end
