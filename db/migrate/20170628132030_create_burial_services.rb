class CreateBurialServices < ActiveRecord::Migration[5.1]
  def change
    create_table :burial_services do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :plot
      t.boolean :symbolic_goodbye
      t.text :notes

      t.timestamps
    end
  end
end
