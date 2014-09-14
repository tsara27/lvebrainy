class Tag < ActiveRecord::Base
	has_and_belongs_to_many :articles

	validates :tag_name, uniqueness: true, presence: true
end
