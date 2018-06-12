class Organization < ApplicationRecord
  has_secure_password
  has_many :data, dependent: :destroy
  has_many :users
  has_many :sushis, dependent: :destroy
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true
end
