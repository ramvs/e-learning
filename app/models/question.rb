class Question < ActiveRecord::Base
	belongs_to :test
	has_many :anserws
	validates :test , presence: true
	validates :content, presence: true

	accepts_nested_attributes_for :anserws , allow_destroy: true
end
