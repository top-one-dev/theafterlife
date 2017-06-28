class CreateFuneralServices < ActiveRecord::Migration[5.1]
  def change
    create_table :funeral_services do |t|
      t.references :member, foreign_key: true
      t.boolean :enabled
      t.string :public
      t.string :color_themes
      t.string :ideal_funeral
      t.string :music
      t.string :flowers
      t.string :food_drinks
      t.text :reading
      t.text :notes

      t.timestamps
    end
  end
end
