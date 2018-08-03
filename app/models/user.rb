class User < ApplicationRecord
  has_and_belongs_to_many :teams
  has_many :given_kudos, :class_name => 'Kudo', :foreign_key => 'giver_id'
  has_many :received_kudos, :class_name => 'Kudo', :foreign_key => 'receiver_id'

  validates_presence_of :name, :surname, :birth_date
  validates :terms_of_service, acceptance: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
