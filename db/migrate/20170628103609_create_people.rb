class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.references :member, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :relation
      t.text :notes

      t.timestamps
    end
  end
end
