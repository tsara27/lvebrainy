class Admin::MyThoughtsController < ApplicationController
	before_action :load_my_thoughts, only: [:edit, :update, :destroy, :show]
  layout "admin_layout"
  def index
  	@my_thought = Article.new
    @my_thought.tags.build
  end

  def show
    
  end

  def create
    @my_thought = Article.new(tuts_params)
    @my_thought.adding_tags(params[:tags][:tag_name], "0") if params[:tags] && params[:tags][:tag_name]
    @my_thought.save ? (redirect_to admin_my_thoughts_path, :notice => "my_thought was successfully saved.") : (render :index)
  end

  def edit
    @my_thought.tags.build
    render :index
  end

  def update
    params[:tags] && params[:tags][:tag_name] ? @my_thought.adding_tags(params[:tags][:tag_name], "1") : @my_thought.adding_tags(nil, "1")
    @my_thought.update_attributes(tuts_params) ? (redirect_to admin_my_thoughts_path, notice: 'my_thought was successfully updated.') : (render :index)
  end

  def destroy
    @my_thought.destroy
    redirect_to admin_my_thoughts_path, :notice => "my_thought was successfully removed."
  end

  def list
    @my_thought = Article.includes(:tags).where("article_type = ?", "2")
    respond_to do |format|
      format.html
      format.json { render json: @my_thought.collect {|t| { :title => t.title, :content => t.content.truncate(20), :tags => t.get_tags, :status => t.parse_status, :id => t.id }} }
    end
  end

private
  def tuts_params 
    params.require(:article).permit(:title, :content, :article_type,:status)
  end

  def load_my_thoughts
    @my_thought = Article.includes(:tags).find(params[:id])
  end
end
