class AddSubscriptionIdToPaymentPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :payment_plans, :subscription_id, :string
  end
end
