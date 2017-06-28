class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  geocoded_by :full_street_address
  after_validation :geocode
end
