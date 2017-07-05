class Pet < ApplicationRecord
  belongs_to :member

  validates_presence_of :name
end
