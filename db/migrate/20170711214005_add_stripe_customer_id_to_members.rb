class AddStripeCustomerIdToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :stripe_customer_id, :string
  end
end
