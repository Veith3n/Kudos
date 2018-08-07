class Team < ApplicationRecord
  has_and_belongs_to_many :users

  validates_presence_of :name, :description
end
