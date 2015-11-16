class Comment < ActiveRecord::Base
	include PublicActivity::Model

	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
	belongs_to :user
	belongs_to :course
	belongs_to :lesson
	validates :description , presence: true 
end
