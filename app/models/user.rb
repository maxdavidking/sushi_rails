class User < ApplicationRecord
  validates :name, presence: true
  validates :organization, presence: true

end
