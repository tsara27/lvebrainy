class Article < ActiveRecord::Base
	has_and_belongs_to_many :tags, -> { uniq }

	def adding_tags(tags)
		tags.each do |the_tag|
			check_tag = Tag.where(:tag_name => the_tag.downcase.delete(","))
			if check_tag.blank?
        self.tags.build({:tag_name => the_tag.downcase.delete(",")})
      else
        self.tags << check_tag
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
