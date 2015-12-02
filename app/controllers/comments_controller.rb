class CommentsController < ApplicationController
  def index
    @report = Report.find params[:report_id]
    render json: @report.comments
  end

  def create
    # Notify creator of report @report.user_id
    # @original_poster = @report.user
    @report = Report.find params[:report_id]
    @comment = @report.comments.build comment_params

    @comment.user = current_user

    @comment.save

    # NotificationEmailer.found_email(@original_poster) if @original_poster != @comment.user
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
end
