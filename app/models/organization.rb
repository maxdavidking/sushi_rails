class Organization < ApplicationRecord
  has_secure_password
  has_many :data
  has_many :users
  has_many :sushis 
end
