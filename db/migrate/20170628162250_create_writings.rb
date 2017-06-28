class CreateWritings < ActiveRecord::Migration[5.1]
  def change
    create_table :writings do |t|
      t.references :member, foreign_key: true
      t.string :author
      t.string :title
      t.text :text
      t.text :notes

      t.timestamps
    end
  end
end
