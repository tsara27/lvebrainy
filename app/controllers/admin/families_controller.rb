class Admin::FamiliesController < ApplicationController
	before_action :load_families, only: [:edit, :update, :destroy, :show]
  layout "admin_layout"
  def index
  	@family = Article.new
    @family.tags.build
  end

  def show
    
  end

  def create
    @family = Article.new(tuts_params)
    @family.adding_tags(params[:tags][:tag_name], "0") if params[:tags] && params[:tags][:tag_name]
    @family.save ? (redirect_to admin_families_path, :notice => "family was successfully saved.") : (render :index)
  end

  def edit
    @family.tags.build
    render :index
  end

  def update
    params[:tags] && params[:tags][:tag_name] ? @family.adding_tags(params[:tags][:tag_name], "1") : @family.adding_tags(nil, "1")
    @family.update_attributes(tuts_params) ? (redirect_to admin_families_path, notice: 'family was successfully updated.') : (render :index)
  end

  def destroy
    @family.destroy
    redirect_to admin_families_path, :notice => "family was successfully removed."
  end

  def list
    @family = Article.includes(:tags).where("article_type = ?", "3")
    respond_to do |format|
      format.html
      format.json { render json: @family.collect {|t| { :title => t.title, :content => t.content.truncate(20), :tags => t.get_tags, :status => t.parse_status, :id => t.id }} }
    end
  end

private
  def tuts_params 
    params.require(:article).permit(:title, :content, :article_type,:status)
  end

  def load_families
    @family = Article.includes(:tags).find(params[:id])
  end
end
