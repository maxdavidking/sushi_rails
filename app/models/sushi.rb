class Sushi < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :validsushi, optional: true
  validates :name, uniqueness: {scope: :organization_id}
  validates :name, presence: true
  validates :endpoint, presence: true
  validates :cust_id, presence: true
  validates :report_start, presence: true
  validates :report_end, presence: true
  validates :report_start, format: {with: /\d{4}-\d{2}-\d{2}/,
    message: "Date must be in the following format: YYYY-MM-DD"}
  validates :report_end, format: {with: /\d{4}-\d{2}-\d{2}/,
    message: "Date must be in the following format: YYYY-MM-DD"}
end
