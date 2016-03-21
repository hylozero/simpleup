class AddDescriptionToSuFile < ActiveRecord::Migration
  def change
    add_column :su_files, :description, :string
  end
end
