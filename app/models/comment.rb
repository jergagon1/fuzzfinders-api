class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  validates :user_id, presence: true
  validates :report_id, presence: true
  validates :content, presence: true

  after_create :send_notification

  #TODO: look at replacing overwriting as_json with Active Model Serializers
  def as_json(options={})
    attributes.merge({comment_username: user.username}).as_json
  end

  private

  def send_notification
    # TODO: do not send email if comment belongs to report's user
    NotificationEmailer.new_report_comment(self).deliver_now if valid?
  end
end
