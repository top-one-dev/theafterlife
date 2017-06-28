class CreateReceptions < ActiveRecord::Migration[5.1]
  def change
    create_table :receptions do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.text :food
      t.text :drink
      t.text :music
      t.text :flowers
      t.text :notes

      t.timestamps
    end
  end
end
