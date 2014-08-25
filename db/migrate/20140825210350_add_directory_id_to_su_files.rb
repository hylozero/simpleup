class AddDirectoryIdToSuFiles < ActiveRecord::Migration
  def change
    add_column :su_files, :directory_id, :integer
  end
end
