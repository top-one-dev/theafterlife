class RenameColumnsInAddresses < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :administrative_area_1, :administrative_area_level_1
    rename_column :addresses, :administrative_area_2, :administrative_area_level_2
  end
end
