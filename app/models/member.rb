class Member < ApplicationRecord
  after_create :after_create
  
  has_one :address, as: :addressable
  has_one :body
  has_one :transportation
  has_one :visitation
  has_one :funeral_service
  has_one :cremation
  has_one :burial_service
  has_one :science_donation
  has_one :reception
  has_one :memorial_contribution
  has_one :obituary
  has_one :memorial_marker
  has_one :headstone
  has_one :program
  has_one :photo_gallery

  has_many :musics
  has_many :writings
  has_many :memories
  has_many :questionnaires
  has_many :pets
  has_many :letters
  has_many :possessions
  has_many :sensitive_infos

  has_many :photos, through: :photo_gallery
  has_many :files

  has_many :people
  has_many :social_accounts

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  def self.from_omniauth(auth)
    social_account = SocialAccount.find_by(provider: auth.provider, uid: auth.uid)
    if social_account
      social_account.member
    else
      puts auth.to_yaml
      member = Member.where(:email => auth.info.email).first_or_create do |member|
        member.email = auth.info.email
        member.password = Devise.friendly_token[0,20]
        member.first_name = auth.info.first_name
        member.last_name = auth.info.last_name
        member.skip_confirmation!
      end
      if member.persisted?
        member.social_accounts.create(:provider => auth.provider, :uid => auth.uid)
      end
      member
    end
  end

  private

  def after_create
    MemberMailer.welcome(self).deliver_now
  end
end
