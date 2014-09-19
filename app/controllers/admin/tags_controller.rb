class Admin::TagsController < ApplicationController
	before_action :load_tag, only: [:edit, :update, :destroy, :show]
  before_action :paloma_load, only: [:index, :edit]
  layout :is_xhr_admin?  
  respond_to :html, :js, only: [:create, :update, :destroy, :the_tags]
  js false, except: [:index, :edit]

	def index
		@tag = Tag.new
	end
  
  def create
		@tag = Tag.new(tag_params)
  end

  def edit
    render :index
  end

  def update
    @tag.update_attributes(tag_params)
  end
  
  def show
  	
  end

  def destroy
    @tag.destroy
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

  def paloma_load
    js "Admin/Tags#load_data"
  end
end
