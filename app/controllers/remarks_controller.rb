class RemarksController < ApplicationController
  def index
    @article = article.find params[:article_id]
    render json: @article.remarks
  end

  def create
    @article = article.find params[:article_id]
    @comment = @article.remarks.create remark_params
    render json: @comment
  end

  def update
    @article = article.find params[:article_id]
    @comment = @article.remarks.find params[:remark_id]
    @comment.update_attributes remark_params
    render json: @comment
  end

  def destroy
    @article = article.find params[:article_id]
    @comment = @article.remarks.find params[:remark_id]
    @comment.destroy
    render json: @comment
  end

  private

  def remark_params
    params.require(:remark).permit(:content, :user_id)
  end
end
