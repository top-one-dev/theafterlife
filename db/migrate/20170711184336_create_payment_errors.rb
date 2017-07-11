class CreatePaymentErrors < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_errors do |t|
      t.references :account_movement, foreign_key: true
      t.string :error_type
      t.string :error_description

      t.timestamps
    end
  end
end
