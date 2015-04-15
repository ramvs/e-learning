class Lesson < ActiveRecord::Base
	belongs_to :course

	validates :course , presence: true

	def courseTitle
		course.title
	end
end
