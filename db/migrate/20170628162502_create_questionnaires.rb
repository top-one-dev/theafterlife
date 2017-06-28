class CreateQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionnaires do |t|
      t.references :member, foreign_key: true
      t.references :question, foreign_key: true
      t.text :answer

      t.timestamps
    end
  end
end
