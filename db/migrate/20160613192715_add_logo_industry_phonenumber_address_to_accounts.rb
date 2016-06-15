class AddLogoIndustryPhonenumberAddressToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :logo, :string
    add_column :accounts, :industry, :string
    add_column :accounts, :phone_number, :string
    add_column :accounts, :address1, :string
    add_column :accounts, :address2, :string
    add_column :accounts, :zip, :string
    add_column :accounts, :town, :string
    add_column :accounts, :country, :string
  end
end
