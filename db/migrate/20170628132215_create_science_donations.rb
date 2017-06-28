class CreateScienceDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :science_donations do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :organization_name
      t.text :notes

      t.timestamps
    end
  end
end
