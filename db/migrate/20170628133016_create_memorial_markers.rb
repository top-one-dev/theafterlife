class CreateMemorialMarkers < ActiveRecord::Migration[5.1]
  def change
    create_table :memorial_markers do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :mm_type
      t.text :writing
      t.text :notes

      t.timestamps
    end
  end
end
