class CreateCremations < ActiveRecord::Migration[5.1]
  def change
    create_table :cremations do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :ashes_disposition
      t.text :notes

      t.timestamps
    end
  end
end
