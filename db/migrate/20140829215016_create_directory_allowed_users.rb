class CreateDirectoryAllowedUsers < ActiveRecord::Migration
  def change
    create_table :directory_allowed_users do |t|
      t.belongs_to :user
      t.belongs_to :directory

      t.timestamps
    end
    add_index :directory_allowed_users, :user_id
    add_index :directory_allowed_users, :directory_id
  end
end
