class Test < ActiveRecord::Base
  belongs_to :lesson
  has_many :questions, dependent: :destroy
  validates :lesson, presence: true, uniqueness: true

  accepts_nested_attributes_for :questions

  def computeScore(userAnswers)
    points = 0
    return points if userAnswers == nil
    questions.all.each do |questionInDb|
      userQuestionAnswers = userAnswers[questionInDb.id.to_s]
      next if userQuestionAnswers==nil
      correctAnswers = findCorrectAnswersIdsForQuestion(questionInDb)
      points += isQuestionCorrectlyAnswered(correctAnswers, userQuestionAnswers) ? 1 : 0
    end
    points
  end

  def saveUserAnswers(userResult, currentUser)
    questions.all.each do |question|
      userQuestion = userResult[question.id.to_s]
      question.anserws.each do |answer|
        saveUserAnswer(answer, currentUser, userQuestion)
      end
    end
  end

  def findCorrectAnswersIdsForQuestion(questionInDb)
    return questionInDb.anserws.where(correct: true).pluck(:id)
  end

  private
    def saveUserAnswer(answer, currentUser, userQuestion)
      userAnswer = userQuestion != nil ? userQuestion.find_index(answer.id.to_s) : nil
      UserAnserw.create({user: currentUser, anserw: answer, correct: resolveCorrect(answer, userAnswer)})
    end

    def resolveCorrect(answer, userAnswer)
      (userAnswer == nil) ? !answer.correct : answer.correct
    end

    def isQuestionCorrectlyAnswered(correctAnswers, userAnswers)
      return false if correctAnswers.length != userAnswers.length
      correctAnswers.each do |correctAnswer|
        return false if userAnswers.find_index(correctAnswer.to_s)==nil
      end
      true
    end

end
