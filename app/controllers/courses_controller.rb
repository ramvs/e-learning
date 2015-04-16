class CoursesController < ApplicationController
	before_filter :find_course , only: [:show,:edit,:update,:destroy]
	decorates_assigned :course
	
	def index
		@courses = Course.all.decorate
		authorize! :read, @courses
	end

	def show
		authorize! :read , @course
	end

	def edit
		authorize! :update , @course
		render 'newedit'
	end

	def update
		authorize! :update , @course
		if @course.update_attributes(course_params)
			redirect_to @course
		else
			render 'newedit'
		end
	end

	def new
		authorize! :create , Course
		@course = Course.new
		render 'newedit'
	end

	def create
		authorize! :create , Course
		@course = Course.new(course_params)
		if @course.save
			redirect_to @course
		else
			render 'newedit'
		end
	end

	def destroy
		authorize! :destroy , @course
		result = @course.destroy
		respond_to do |format|
			format.html {redirect_to courses_path}
			format.js { @id = result ? result.id : ""}
		end
	end

	private
		def course_params
			params.require(:course).permit(:title,:description)
		end

		def find_course
			@course = Course.find(params[:id])
		end
end
