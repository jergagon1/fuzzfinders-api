class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def create
    @article = Article.new article_params
    @article.user_id = session[:user_id]
    if @article.save
      render json: @article, status: :created
    else
      render "Article not saved"
    end
  end

  def show
    @article = Article.find(params[:id])
    @remarks = Remark.where(article_id: params[:id])
    render :json => @article.to_json(:include => [:remarks])
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :user_id)
  end
end