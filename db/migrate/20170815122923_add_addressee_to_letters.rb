class AddAddresseeToLetters < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :addressee, :string
  end
end
