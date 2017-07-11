class CreatePaymentPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_plans do |t|
      t.references :member, foreign_key: true
      t.string :interval
      t.decimal :amount, precision: 30, scale: 8
      t.timestamp :started_at
      t.timestamp :cancelled_at

      t.timestamps
    end
  end
end
