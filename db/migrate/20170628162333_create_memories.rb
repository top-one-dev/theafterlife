class CreateMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :memories do |t|
      t.references :member, foreign_key: true
      t.integer :order
      t.string :heading
      t.text :text
      t.text :notes

      t.timestamps
    end
  end
end
