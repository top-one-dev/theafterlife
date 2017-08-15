class SensitiveInfo < ApplicationRecord
  belongs_to :member

  attr_accessor  :encryption_key
  attr_encrypted :instruction, key: :encryption_key, algorithm: 'aes-256-cbc'
end
