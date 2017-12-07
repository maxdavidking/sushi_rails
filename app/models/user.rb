class User < ApplicationRecord
  validates :name, presence: true
  validates :organization, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

end
