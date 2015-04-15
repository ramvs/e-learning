class TestsController < ApplicationController
	before_filter :find_test , only:[:show, :edit,:update,:destroy]
	before_filter :find_lesson , only:[:new,:create]
	decorates_assigned :test
	def index
		@tests = Test.all
	end

	def show
	end

	def edit
	end

	def new
		if @lesson.test
			redirect_to [@lesson,@lesson.test]
		else
			@test = @lesson.build_test
		end
	end

	def create
		@test = @lesson.create_test(test_params)
		if @test.save
			redirect_to [@lesson,@test]
		else
			render "new"
		end
	end

	def update
		if @test.update_attributes(test_params)
			redirect_to [@lesson,@test]
		else
			render 'new'
		end
	end

	def destroy
		@test.destroy
		redirect_to [@lesson.course,@lesson]
	end


	private

		def find_test
			find_lesson
			@test = @lesson.test
		end

		def find_lesson
			@lesson = Lesson.find(params[:lesson_id])
		end

		def test_params
			params.require(:test).permit(:title,:description)
		end
end
