class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.references :member, foreign_key: true
      t.string :design
      t.text :text_on_cover
      t.text :words_i_want_to_included
      t.text :notes

      t.timestamps
    end
  end
end
