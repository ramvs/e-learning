class Course < ActiveRecord::Base
	include PublicActivity::Model

	validates :title , presence: true , uniqueness: true
	has_many :comments
	has_many :lessons , dependent: :destroy
	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
end
