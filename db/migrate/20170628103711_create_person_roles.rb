class CreatePersonRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :person_roles do |t|
      t.references :person, foreign_key: true
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
