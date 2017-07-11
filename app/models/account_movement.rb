class AccountMovement < ApplicationRecord
  before_create :before_create

  belongs_to :member

  has_many :payment_errors

  def before_create
    self.payment_status = 'pending'
    self.uuid = SecureRandom.uuid
  end
end
