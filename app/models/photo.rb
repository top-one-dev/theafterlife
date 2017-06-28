class Photo < ApplicationRecord
  belongs_to :member
  belongs_to :imageable, polymorphic: true

  has_attached_file :file
end
