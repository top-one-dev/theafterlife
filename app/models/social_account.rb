class SocialAccount < ApplicationRecord
  belongs_to :member, optional: true
end
