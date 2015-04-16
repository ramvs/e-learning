class Lesson < ActiveRecord::Base
	belongs_to :course
	has_one :test
	validates :course , presence: true

	def courseTitle
		course.title
	end
end
