class RemoveColumnProjectIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :project_id
  end
end
