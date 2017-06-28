class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :name
      t.string :address
      t.string :street_number
      t.string :route
      t.string :neighborhood
      t.string :sublocality
      t.string :administrative_area_1
      t.string :administrative_area_2
      t.string :country
      t.string :postal_code
      t.decimal :lat, precision: 10, scale: 7
      t.decimal :lng, precision: 10, scale: 7
      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
