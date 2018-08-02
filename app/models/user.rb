class User < ApplicationRecord
  has_and_belongs_to_many :teams

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
