class Admin::TutorialsController < ApplicationController
	layout "admin_layout"
  def index
  	@tutorial = Article.new
    @tutorial.tags.build
  end

  def create
    @tutorial = Article.new(tuts_params)
    @tutorial.adding_tags(params[:tags][:tag_name]) if params[:tags][:tag_name]
    @tutorial.save ? (redirect_to tutorials_path, :notice => "Tutorials was successfully saved.") : (redirect_to tutorials_path)
  end

  def edit
    @tutorial = Article.find(params[:id])
    @tutorial.tags.build
    render :index
  end

  def update
    @tutorial = Article.find(params[:id])
    @tutorial.update_attribute (name, value)
  end

  def list
    @tutorial = Article.all
    respond_to do |format|
      format.html
      format.json { render json: @tutorial.collect {|t| { :title => t.title, :content => t.content, :tags => t.get_tags, :status => t.parse_status}} }
    end
  end

private
  def tuts_params 
    params.require(:article).permit(:title, :content, :status)
  end
end
