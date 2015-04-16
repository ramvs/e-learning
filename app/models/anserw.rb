class Anserw < ActiveRecord::Base
	belongs_to :question
	validates :question , presence: true
	validates :content , presence: true
end
