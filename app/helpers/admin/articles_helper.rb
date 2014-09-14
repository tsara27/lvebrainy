module Admin::ArticlesHelper
	def title_type_based(at)
		at.nil? ? nil : ARTICLE_TYPES.find {|x| x[:id] == at.to_i }[:type]
	end

	def title_placeholder(at)
		at.nil? ? nil : ARTICLE_TYPES.find {|x| x[:id] == at.to_i }[:placeholder]
	end
end
