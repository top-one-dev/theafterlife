class PaymentError < ApplicationRecord
  belongs_to :account_movement
end
