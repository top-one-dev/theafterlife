class ScienceDonation < ApplicationRecord
  belongs_to :member
  
  has_one :address, as: :addressable
end
