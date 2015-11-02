class Anserw < ActiveRecord::Base
  belongs_to :question
	has_many :user_anserws
  validates :question, presence: true
  validates :content, presence: true
end
