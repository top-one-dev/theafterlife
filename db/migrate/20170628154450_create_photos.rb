class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.references :member, foreign_key: true
      t.integer :imageable_id
      t.string :imageable_type
      t.text :caption

      t.timestamps
    end
  end
end
