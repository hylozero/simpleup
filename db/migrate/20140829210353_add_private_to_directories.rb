class AddPrivateToDirectories < ActiveRecord::Migration
  def change
    add_column :directories, :private, :boolean
  end
end
