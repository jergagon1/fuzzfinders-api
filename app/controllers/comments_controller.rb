class CommentsController < ApplicationController
  require 'pusher'

  def index
    @report = Report.find params[:report_id]
    render json: @report.comments
  end

  def create
    @report = Report.find params[:report_id]
    @comment = @report.comments.create comment_params
    if @comment.save
      trigger_pusher_notification(@comment)
    end
    render json: @comment
  end

  def update
    @report = Report.find params[:report_id]
    @comment = @report.comments.find params[:comment_id]
    @comment.update_attributes comment_params
    render json: @comment
  end

  def destroy
    @report = Report.find params[:report_id]
    @comment = @report.comments.find params[:comment_id]
    @comment.destroy
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :report_id)
  end

  # trigger pusher notification on comment creation
  def trigger_pusher_notification(comment)
    # trigger a notification to Pusher service
    pusher = Pusher::Client.new app_id: ENV['PUSHER_APP_ID'], key: ENV['PUSHER_KEY'], secret: ENV['PUSHER_SECRET']
    report = comment.report
    pusher.trigger(
      "report_comments_#{comment.report_id}",
      'report_commented',
      { 
        :message => "Comment by #{comment.user.username}: #{report.report_type} #{report.animal_type}",
        :comment_id => comment.id,
      }
    )
  end
end
