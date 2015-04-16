class Lesson < ActiveRecord::Base
	belongs_to :course
	has_one :test , dependent: :destroy
	has_many :documents, dependent: :destroy
	validates :course , presence: true

	def courseTitle
		course.title
	end
end
