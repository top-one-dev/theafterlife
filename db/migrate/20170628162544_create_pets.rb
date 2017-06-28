class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.references :member, foreign_key: true
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
