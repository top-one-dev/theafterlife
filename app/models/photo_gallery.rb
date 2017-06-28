class PhotoGallery < ApplicationRecord
  belongs_to :member

  has_many :photos, as: :imageable
end
