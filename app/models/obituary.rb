class Obituary < ApplicationRecord
  belongs_to :member

  has_one :photo, as: :imageable
end
