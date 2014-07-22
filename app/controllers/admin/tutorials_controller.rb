class Admin::TutorialsController < ApplicationController
	before_action :load_tutorial, only: [:edit, :update, :destroy, :show]
  layout "admin_layout"
  def index
  	@tutorial = Article.new
    @tutorial.tags.build
  end

  def show
    
  end

  def create
    @tutorial = Article.new(tuts_params)
    @tutorial.adding_tags(params[:tags][:tag_name], "0") if params[:tags] && params[:tags][:tag_name]
    @tutorial.save ? (redirect_to tutorials_path, :notice => "Tutorial was successfully saved.") : (render :index)
  end

  def edit
    @tutorial.tags.build
    render :index
  end

  def update
    params[:tags] && params[:tags][:tag_name] ? @tutorial.adding_tags(params[:tags][:tag_name], "1") : @tutorial.adding_tags(nil, "1")
    @tutorial.update_attributes(tuts_params) ? (redirect_to tutorials_path, notice: 'Tutorial was successfully updated.') : (render :index)
  end

  def destroy
    @tutorial.destroy
    redirect_to tutorials_path, :notice => "Tutorial was successfully removed."
  end

  def list
    @tutorial = Article.includes(:tags)
    respond_to do |format|
      format.html
      format.json { render json: @tutorial.collect {|t| { :title => t.title, :content => t.content.truncate(20), :tags => t.get_tags, :status => t.parse_status, :id => t.id }} }
    end
  end

private
  def tuts_params 
    params.require(:article).permit(:title, :content, :article_type,:status)
  end

  def load_tutorial
    @tutorial = Article.includes(:tags).find(params[:id])
  end
end
