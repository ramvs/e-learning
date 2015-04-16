class QuestionsController < ApplicationController
	before_filter :find_test , only: [:index,:new,:create]
	before_filter :find_question , only: [:edit,:update,:destroy,:show]
	decorates_assigned :question
	decorates_assigned :test

	def show
		authorize! :read, @question
	end

	def index
		authorize! :read, @test
		@questions = @test.questions.decorate
		authorize! :read, @questions
	end

	def new
		authorize! :update , @test
		@question = @test.questions.build
		@create = true
	end

	def edit
		authorize! :update , @test
		render 'new'
	end

	def update
		authorize! :update , @test
		if @question.update_attributes(question_params)
			redirect_to test_questions_path(@test)
		else
			render 'new'
		end
	end

	def create
		authorize! :update , @test
		@question = @test.questions.create(question_params)
		if @question.save
			redirect_to edit_test_question_path(@test,@question)
		else
			render 'new'
		end
	end

	def destroy
		authorize! :update , @test
		@question.destroy
		redirect_to test_questions_path(@test)
	end


	private
		def find_test
			@test = Test.find(params[:test_id])
		end

		def question_params
			params.require(:question).permit(:content,anserws_attributes: 
				[:id, :content , :correct , :_destroy])
		end

		def find_question
			find_test
			@question = @test.questions.find(params[:id])
		end
end
