class TestResultsController < ApplicationController
  before_filter :find_lesson , only: [:index]
  before_filter :find_test_result , only: [:show]

  decorates_assigned :lesson

  def index
    @results = @lesson.findTestResults
  end

  def show
  end

  private
    def find_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def find_test_result
      find_lesson
      @result = TestResult.find(params[:id])
    end
end