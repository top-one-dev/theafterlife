class ChangeBurialServicesColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :burial_services, :symbolic_goodbye, :string
    add_column :burial_services, :coffin_selection, :string
    rename_column :burial_services, :symbolic_goodbye, :symbolic_marker
  end
end
