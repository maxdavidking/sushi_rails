class Validsushi < ApplicationRecord
  has_many :sushis, dependent: :nullify
  validates :name, presence: true
  validates :endpoint, presence: true
  validates :cust_id, presence: true
  validates :report_start, presence: true
  validates :report_end, presence: true
end
