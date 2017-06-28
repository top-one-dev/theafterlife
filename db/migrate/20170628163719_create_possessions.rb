class CreatePossessions < ActiveRecord::Migration[5.1]
  def change
    create_table :possessions do |t|
      t.references :member, foreign_key: true
      t.string :what
      t.string :who
      t.text :notes

      t.timestamps
    end
  end
end
