class AddUploadColumnsToSuFile < ActiveRecord::Migration
  def up
    add_attachment :su_files, :upload
  end
  
  def down
    remove_attachment :su_files, :upload
  end
end
