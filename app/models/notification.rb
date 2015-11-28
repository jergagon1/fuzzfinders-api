class Notification
  def self.notify_about_new_report(report)
    $pusher.trigger(
      'fuzzflash',
      'report_created',
      {
        message: "Fuzzflash: #{report.report_type.to_s.capitalize} #{report.animal_type_normalized}",
        report_id: report.id,
        report_type: report.report_type,
        latitude: report.lat,
        longitude: report.lng,
        user_id: report.user_id
      }
    )
  end


  def self.notify_about_new_comment_except_comments_user(comment)
    report = comment.report

    $pusher.trigger(
      'fuzzflash', #{comment.report_id}",
      'report_commented',
      {
        message: "Comment by #{comment.user.username}: #{report.report_type} #{report.animal_type}",
        report_id: report.id,
        comment_id: comment.id,
        comment: comment
      }
    )

    comment.report.subscribers.each do |subscriber|
      # don't notify comment's owner by email
      next if subscriber.id == comment.user_id

      # TODO: move it to queue
      NotificationEmailer.new_comment(comment, subscriber).deliver_now
    end
  end
end
