class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
    @remarks = Remark.where(article_id: params[:id])
    render :json => @article.to_json(:include => [:remarks])
  end

end
