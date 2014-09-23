class Public::HomeController < ApplicationController
  respond_to :html, :js, only: [:index]
	js false, except: [:index]
	
	def index
		@articles = Article.includes(:tags).page params[:page]
	end

  def call_articles
		@articles = Article.includes(:tags).page params[:page]
  end
  
  private
  def paloma_load
    js "Public/Articles#load_data"
  end

end
