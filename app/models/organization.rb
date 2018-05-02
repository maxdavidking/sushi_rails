class Organization < ApplicationRecord
  has_secure_password
  has_many :data
  has_many :users
  has_many :sushis
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true
end
