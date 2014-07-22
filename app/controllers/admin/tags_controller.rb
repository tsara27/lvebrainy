class Admin::TagsController < ApplicationController
	before_action :load_tag, only: [:edit, :update, :destroy, :show]
  layout "admin_layout"

	def index
		@tag = Tag.new
	end
  
  def create
		@tag = Tag.new(tag_params)
    @tag.save ? (redirect_to tags_path, :notice => "Tag was successfully saved.") : (render :index)
  end

  def edit
    render :index
  end

  def update
    @tag.update_attributes(tag_params) ? (redirect_to tags_path, notice: 'Tag was successfully updated.') : (render :index)
  end
  
  def show
  	
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, :notice => "Tag was successfully removed."
  end

	def list
		@term = params[:term].downcase if params[:term]
		@tags = Tag.where("tags.tag_name LIKE ?", "%#{@term}%")
    respond_to do |format|
      format.html
      format.json { render json: @tags.collect {|cc| cc.tag_name }}
    end  
	end

	def the_tags
	  @tag = Tag.includes(:articles)
    respond_to do |format|
      format.html
      format.json { render json: @tag.collect {|t| { :tag_name => t.tag_name, :total => t.articles.count, :id => t.id }} }
    end
	end

	private
  def tag_params 
    params.require(:tag).permit(:tag_name)
  end
  
  def load_tag
    @tag = Tag.includes(:articles).find(params[:id])
  end
end
