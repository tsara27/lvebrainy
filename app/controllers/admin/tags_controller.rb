class Admin::TagsController < ApplicationController
	def list
		@term = params[:term].downcase if params[:term]
		@tags = Tag.where("tags.tag_name LIKE ?", "%#{@term}%")
    respond_to do |format|
      format.html
      format.json { render json: @tags.collect {|cc| cc.tag_name }}
    end  
	end
end
