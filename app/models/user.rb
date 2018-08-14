class User < ApplicationRecord
  has_and_belongs_to_many :teams
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id'
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id'

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name, :surname, :birth_date, unless: :skip_validation
  validates :terms_of_service, acceptance: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.skip_validation = true
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name.split[0]
      user.surname = auth.info.name.split[1]
      user.terms_of_service = true
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
