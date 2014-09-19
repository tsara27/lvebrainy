class Admin::ArticlesController < ApplicationController
	before_action :load_article, only: [:edit, :update, :destroy, :show]
  before_action :paloma_load, only: [:index, :edit]
  layout :is_xhr_admin?
  respond_to :html, :js, only: [:create, :update, :destroy, :the_articles]
  js false, except: [:index, :edit]
  
  def index
  	@article = Article.new
    @article.tags.build
  end

  def show
    
  end

  def create
    @article = Article.new(tuts_params)
    new_tags if params[:tags] && params[:tags][:tag_name]
    flash[:notice] = "Article was successfully saved." if @article.save
  end

  def edit
    @article.tags.build
    render :index
  end

  def update
    params[:tags] && params[:tags][:tag_name] ? new_tags : zero_tags
    @saved = @article.update_attributes(tuts_params) ? 1 : 0
  end

  def destroy
    @article.destroy
  end

  def list
    @article = Article.includes(:tags).where("article_type = ?", params[:at])
    respond_to do |format|
      format.html
      format.json { render json: @article.collect {|t| { :title => t.title, :content => t.content.truncate(20), :tags => t.get_tags, :status => t.parse_status, :id => t.id }} }
    end
  end
  
  def the_articles
    @articles = Article.includes(:tags).where("article_type = ?", params[:article_type]).page params[:page]
  end

private
  def tuts_params 
    params.require(:article).permit(:title, :content, :article_type,:status)
  end

  def load_article
    @article = Article.includes(:tags).find(params[:id])
  end

  def new_tags
    @article.adding_tags(params[:tags][:tag_name], "1")
  end

  def zero_tags
    @article.adding_tags(nil, "1")
  end

  def paloma_load
    js "Admin/Articles#load_data", at: params[:at]
  end
end
