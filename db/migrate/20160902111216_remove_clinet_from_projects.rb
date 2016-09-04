class RemoveClinetFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :client 
  end
end
