class Person < ApplicationRecord
  belongs_to :member

  has_one :address, as: :addressable

  has_many :person_roles
  has_many :roles, through: :person_roles
end
