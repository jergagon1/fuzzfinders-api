class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse_order
    render json: @articles
  end

  def create
    @article = Article.new article_params
    if @article.save
      render json: { :article => @article, :tags => @article.all_tags }, status: :created
    else
      render json: { :errors => @article.errors.full_messages }
    end
  end

  def show
    @article = Article.find(params[:id])
    @remarks = Remark.where(article_id: params[:id])
    @tags = @article.all_tags
    render json: { :article => @article, :remarks => @remarks, :tags => @tags }
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :user_id, :all_tags)
  end
end