class Tag < ActiveRecord::Base
  has_many :report_tags
  has_many :reports, through: :report_tags
end
