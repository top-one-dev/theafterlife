class CreateBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :bodies do |t|
      t.references :member, foreign_key: true
      t.boolean :donate_organs
      t.string :ceremony_type
      t.text :notes

      t.timestamps
    end
  end
end
