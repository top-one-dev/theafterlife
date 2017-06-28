class MemberFile < ApplicationRecord
  belongs_to :member

  has_attached_file :file
end
