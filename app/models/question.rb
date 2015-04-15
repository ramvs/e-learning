class Question < ActiveRecord::Base
	belongs_to :test
	validates :test , presence: true
	validates :content, presence: true
end
