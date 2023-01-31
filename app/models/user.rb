class User < ApplicationRecord
  has_many :invitees
  has_many :viewing_parties, through: :invitees
  validates_presence_of :name, :email
  validates_uniqueness_of :email
end
