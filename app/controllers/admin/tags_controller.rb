class Admin::TagsController < ApplicationController
	before_action :load_tag, only: [:edit, :update, :destroy, :show]
  layout :is_xhr_admin?  
  respond_to :html, :js, only: [:create, :update, :the_tags]
  js false, except: [:index, :edit]

	def index
		@tag = Tag.new
    js "Admin/Tags#load_data", page: params[:page]
	end
  
  def create
		@tag = Tag.new(tag_params)
  end

  def edit
    render :index
    js "Admin/Tags#load_data", page: params[:page]
  end

  def update
    @tag.update_attributes(tag_params)
  end
  
  def show
  	
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, :notice => "Tag was successfully removed."
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
	  @tags = Tag.includes(:articles).page params[:page]
  end

	private
  def tag_params 
    params.require(:tag).permit(:tag_name)
  end
  
  def load_tag
    @tag = Tag.includes(:articles).find(params[:id])
  end
end
