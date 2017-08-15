class AddPublicToReceptions < ActiveRecord::Migration[5.1]
  def change
    add_column :receptions, :public, :string
  end
end
