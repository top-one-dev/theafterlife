class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.references :member, foreign_key: true
      t.string :artist
      t.string :title
      t.text :reason

      t.timestamps
    end
  end
end
