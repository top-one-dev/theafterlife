class CreateMemorialContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :memorial_contributions do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :sent_to
      t.text :notes

      t.timestamps
    end
  end
end
