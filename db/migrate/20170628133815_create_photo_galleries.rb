class CreatePhotoGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_galleries do |t|
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
