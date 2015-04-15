class CoursesController < ApplicationController
	before_filter :find_course , only: [:show,:edit,:update]

	def index
		@courses = Course.all
	end

	def show
	end

	def edit
		@title = "Edit - #{@course.title}"
		render 'newedit'
	end

	def update
		if @course.update_attributes(course_params)
			redirect_to @course
		else
			@title = "Edit - #{@course.title}"
			render 'newedit'
		end
	end

	def new
		@course = Course.new
		@title = "New course"
		render 'newedit'
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			redirect_to @course
		else
			render 'new'
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
