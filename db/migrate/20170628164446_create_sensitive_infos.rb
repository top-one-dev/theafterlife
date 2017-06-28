class CreateSensitiveInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :sensitive_infos do |t|
      t.references :member, foreign_key: true
      t.string :info_type
      t.string :title
      t.string :instruction
      t.text :notes

      t.timestamps
    end
  end
end
