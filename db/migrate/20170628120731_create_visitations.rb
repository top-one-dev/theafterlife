class CreateVisitations < ActiveRecord::Migration[5.1]
  def change
    create_table :visitations do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :public
      t.text :notes

      t.timestamps
    end
  end
end
