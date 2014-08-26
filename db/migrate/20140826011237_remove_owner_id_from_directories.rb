class RemoveOwnerIdFromDirectories < ActiveRecord::Migration
  def up
    remove_column :directories, :owner_id
  end

  def down
    add_column :directories, :owner_id, :integer
  end
end
