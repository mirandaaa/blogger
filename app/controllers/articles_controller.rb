class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:index, :show]
  helper_method :articles_by_month, :article

  def article
    @cached_article ||= Article.find_or_initialize_by(id: params[:id])
  end


  def index
    @articles = Article.all
  end

  def articles_by_month
    @articles.group_by { |article| article.created_at.beginning_of_month }
  end

  def show
    @comment = Comment.new
    @comment.article_id = article.id
  end

  def new
  end

  def create
    article.attributes = article_params
    article.save
    flash.notice = "Article '#{article.title}' Created!"
    redirect_to article_path(article)
  end

  def destroy
    article.destroy
    flash.notice = "Article '#{article.title}' Deleted!"
    redirect_to articles_path
  end

  def edit
  end

  def update
    article.update(article_params)
    flash.notice = "Article '#{article.title}' Updated!"
    redirect_to article_path(article)
  end

end
