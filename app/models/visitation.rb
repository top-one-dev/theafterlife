class Visitation < ApplicationRecord
  belongs_to :member

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
end
