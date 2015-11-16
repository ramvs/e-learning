class TestsController < ApplicationController
	before_filter :find_test , only:[:show, :edit,:update,:destroy]
	before_filter :find_lesson , only:[:new,:create]
	decorates_assigned :test

	def index
		@tests = Test.all
		authorize! :read, @tests
	end

	def show
		authorize! :read, @test
	end

	def edit
		authorize! :update , @test
	end

	def solve
		@result = TestResult.createAndSafe(Test.find(params[:test]), params[:solve], current_user)
		@result.create_activity(key: 'test_result.create', owner: current_user) if @result.id != nil
	end

	def new
		authorize! :create , Test
		authorize! :update, @lesson
		if @lesson.test
			redirect_to [@lesson,@lesson.test]
		else
			@test = @lesson.build_test
		end
	end

	def create
		authorize! :create , Test
		authorize! :update, @lesson
		@test = @lesson.create_test(test_params)
		if @test.save
			@test.create_activity key: 'test.create', owner: current_user
			redirect_to [@lesson,@test]
		else
			render "new"
		end
	end

	def update
		authorize! :update , @test
		authorize! :update, @lesson
		if @test.update_attributes(test_params)
			@test.create_activity key: 'test.update', owner: current_user
			redirect_to [@lesson,@test]
		else
			render 'new'
		end
	end

	def destroy
		authorize! :destroy, @test
		authorize! :update, @lesson
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
