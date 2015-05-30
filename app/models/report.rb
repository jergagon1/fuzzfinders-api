class Report < ActiveRecord::Base
  belongs_to :user
  has_many :report_tags
  has_many :tags, through: :report_tags
  has_many :comments
end
