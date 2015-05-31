class Report < ActiveRecord::Base
  has_many :report_tags
  has_many :tags, through: :report_tags
  has_many :comments
end
