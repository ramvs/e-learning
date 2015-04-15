class Test < ActiveRecord::Base
	belongs_to :lesson
	validates :lesson , presence: true , uniqueness: true
end
