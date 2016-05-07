class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse_order
    render json: @articles
  end

  def create
    @article = Article.new article_params
    if @article.save
      render json: { :article => @article, :tags => @article.tag_list }, status: :created
    else
      render json: { :errors => @article.errors.full_messages }
    end
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tags
    render json: { :article => @article, :tags => @tags }
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :user_id, :tag_list)
  end
end
