class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :report

  validates :user_id, presence: true
  validates :report_id, presence: true
  validates :user_id, uniqueness: { scope: [:report_id] }
end
