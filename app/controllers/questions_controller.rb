class QuestionsController < ApplicationController
	before_filter :find_test , only: [:index,:new,:create]
	before_filter :find_question , only: [:edit,:update,:destroy]
	decorates_assigned :question
	decorates_assigned :test

	def index
		@questions = @test.questions.decorate
	end

	def new
		@question = @test.questions.build
	end

	def edit
		render 'new'
	end

	def update
		if @question.update_attributes(question_params)
			redirect_to test_questions_path(@test)
		else
			render 'new'
		end
	end

	def create
		@question = @test.questions.create(question_params)
		if @question.save
			redirect_to test_questions_path(@test)
		else
			render 'new'
		end
	end

	def destroy
		@question.destroy
		redirect_to test_questions_path(@test)
	end


	private
		def find_test
			@test = Test.find(params[:test_id])
		end

		def question_params
			params.require(:question).permit(:content)
		end

		def find_question
			find_test
			@question = @test.questions.find(params[:id])
		end
end
