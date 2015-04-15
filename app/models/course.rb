class Course < ActiveRecord::Base
	validates :title , presence: true , uniqueness: true

	has_many :lessons , dependent: :destroy
end
