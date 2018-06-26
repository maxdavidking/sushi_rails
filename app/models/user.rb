class User < ApplicationRecord
  belongs_to :organization, optional: true
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash.fetch("uid"), provider: auth_hash.fetch("provider"))
      user.name = auth_hash["info"].fetch("name")
      user.save!
      user
    end
  end
end
