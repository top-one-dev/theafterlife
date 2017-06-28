class Role < ApplicationRecord
  has_many :person_roles
  has_many :people, through: :person_roles
end
