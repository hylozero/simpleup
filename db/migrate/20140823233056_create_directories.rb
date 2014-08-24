class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :title
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
  end
end
