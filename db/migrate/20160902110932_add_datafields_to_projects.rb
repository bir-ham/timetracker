class AddDatafieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :customer_id, :integer
    add_column :projects, :invocie_id, :integer
    add_column :projects, :status, :string
    add_column :projects, :progress, :integer
    add_column :projects, :description, :text
  end
end
