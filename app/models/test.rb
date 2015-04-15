class Test < ActiveRecord::Base
	belongs_to :lesson
	has_many :questions
	validates :lesson , presence: true , uniqueness: true
end
