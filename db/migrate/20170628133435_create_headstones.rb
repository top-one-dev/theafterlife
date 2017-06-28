class CreateHeadstones < ActiveRecord::Migration[5.1]
  def change
    create_table :headstones do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.text :epitaph
      t.boolean :individual
      t.string :material
      t.string :flower_vase
      t.text :notes

      t.timestamps
    end
  end
end
