class Question < ActiveRecord::Base
  belongs_to :test
  has_many :anserws, dependent: :destroy
  validates :test, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :anserws, allow_destroy: true

  def getUsersAnswers user
    UserAnserw.where(anserw: anserws).where(user: user)
  end

end
