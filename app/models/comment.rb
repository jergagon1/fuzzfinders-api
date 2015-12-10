class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  validates :user_id, presence: true
  validates :report_id, presence: true
  validates :content, presence: true

  after_commit :subscribe_user_and_notify_all

  #TODO: look at replacing overwriting as_json with Active Model Serializers
  def as_json(options={})
    attributes.merge({
      comment_username: user.try(:username),
      subscriptions: user.try(:subscribed_reports).try(:ids),
      image: image.url(:thumb)
    }).as_json
  end

  mount_uploader :image, ImageUploader

  private

  def subscribe_user_and_notify_all
    user.subscriptions.create(report: report)

    Notification.notify_about_new_comment_except_comments_user(self)
  end

  # def send_notification
  #   # TODO: do not send email if comment belongs to report's user
  #   NotificationEmailer.new_report_comment(self).deliver_now if valid?
  # end
end
