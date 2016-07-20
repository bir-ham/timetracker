class RemoveColumnNicknameFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :nickname
  end
end
