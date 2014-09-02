class AddOriginalOwnerIdToDirectories < ActiveRecord::Migration
  def change
    add_column :directories, :original_owner_id, :integer
  end
end
