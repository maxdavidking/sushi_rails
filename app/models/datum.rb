class Datum < ApplicationRecord
  has_one_attached :file
  belongs_to :sushi
  belongs_to :organization
end
