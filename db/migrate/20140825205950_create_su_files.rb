class CreateSuFiles < ActiveRecord::Migration
  def change
    create_table :su_files do |t|

      t.timestamps
    end
  end
end
