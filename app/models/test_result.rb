class TestResult < ActiveRecord::Base
  include PublicActivity::Model
  belongs_to :user
  belongs_to :test
  has_many :user_anserws
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  validates_presence_of :user
  validates_presence_of :test
  validates_uniqueness_of :test , scope: :user , message: "has already been taken! Changes won't be saved!"

  validates_presence_of :max
  validates_presence_of :points

  attr_accessor :questions_results_set

  def self.createAndSafe(test, userResult, currentUser)
    testResult = TestResult.new({user: currentUser, test: test, max: test.questions.count, points: 0})
    testResult.questions_results_set = []
    test.questions.all.each do |question|
      testResult.questions_results_set << question
      processAnswer(question, testResult, userResult)
    end
    testResult.save
    testResult
  end

  def self.processAnswer(question, testResult, userResult)
    error = false
    question.user_answers = []
    question.anserws.each do |answer|
      isCorrect = userResult!=nil && checkIfCorrect(answer, userResult[question.id.to_s])
      question.user_answers << testResult.user_anserws.build({anserw: answer, correct: isCorrect})
      error = true unless isCorrect
    end
    testResult.points+=1 unless error
  end

  def self.checkIfCorrect(answer, userQuestion)
    userAnswer = userQuestion != nil ? userQuestion.find_index(answer.id.to_s) : nil
    return (userAnswer == nil) ? !answer.correct : answer.correct
  end
end
