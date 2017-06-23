class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable, :lockable
end
