class CreateTransportations < ActiveRecord::Migration[5.1]
  def change
    create_table :transportations do |t|
      t.references :member, foreign_key: true
      t.string :transport_of_deceased
      t.string :transport_of_family
      t.text :notes

      t.timestamps
    end
  end
end
