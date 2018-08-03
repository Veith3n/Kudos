class User < ApplicationRecord
  has_and_belongs_to_many :teams

  validates_presence_of :name, :surname, :birth_date
  validates :terms_of_service, acceptance: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
