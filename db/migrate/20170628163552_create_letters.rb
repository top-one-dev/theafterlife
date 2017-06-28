class CreateLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :letters do |t|
      t.references :member, foreign_key: true
      t.text :text
      t.date :date_of_creation

      t.timestamps
    end
  end
end
