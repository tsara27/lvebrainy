class Article < ActiveRecord::Base
	has_and_belongs_to_many :tags, -> { uniq }

	validates :title, uniqueness: true

	def adding_tags(tags,conf)
  	self.tags.destroy_all if conf == "1"
  	if tags.size > 0
  		tags.each do |the_tag|
			  check_tag = Tag.where(:tag_name => the_tag.downcase.delete(",").delete(" "))
			  check_tag.blank? ? self.tags.build({:tag_name => the_tag.downcase.delete(",").delete(" ")}) : self.tags << check_tag
      end
  	end
	end

	def parse_status
		(self.status == 1) ? "Draft" : "Posted" 
	end

	def get_tags
		self.tags.map(&:tag_name).join(", ")
	end
end