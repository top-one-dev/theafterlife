class CreateObituaries < ActiveRecord::Migration[5.1]
  def change
    create_table :obituaries do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.datetime :birth_day
      t.string :birth_place
      t.text :schools
      t.text :career
      t.text :activities
      t.text :remember_me_for
      t.text :other
      t.string :where_to_publish
      t.text :my_obituary
      t.text :notes

      t.timestamps
    end
  end
end
