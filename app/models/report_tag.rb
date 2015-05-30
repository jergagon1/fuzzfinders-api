class ReportTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :report
end
