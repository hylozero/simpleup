class CreateDirectoryOwners < ActiveRecord::Migration
  def change
    create_table :directory_owners do |t|
      t.belongs_to :user
      t.belongs_to :directory

      t.timestamps
    end
    add_index :directory_owners, :user_id
    add_index :directory_owners, :directory_id
  end
end
