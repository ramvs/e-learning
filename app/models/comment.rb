class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :lesson
	validates :description , presence: true 
end