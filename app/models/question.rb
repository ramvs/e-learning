class Question < ActiveRecord::Base
  belongs_to :test
  has_many :anserws, dependent: :destroy
  validates :test, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :anserws, allow_destroy: true

  attr_accessor :user_answers

  def getTestResultAnswers(test_result)
    UserAnserw.where(anserw: anserws).where(test_result: test_result)
  end

end
