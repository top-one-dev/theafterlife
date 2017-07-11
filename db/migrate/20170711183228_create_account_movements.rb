class CreateAccountMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :account_movements do |t|
      t.references :member, foreign_key: true
      t.decimal :amount, precision: 30, scale: 8
      t.decimal :confirmed_amount, precision: 30, scale: 8
      t.timestamp :paid_at
      t.string :uuid
      t.string :payment_type
      t.string :payment_identificator
      t.string :payment_status

      t.timestamps
    end
    add_index :account_movements, :uuid
  end
end
