class CoursesController < ApplicationController
	before_filter :find_course , only: [:show,:edit,:update,:destroy]
	decorates_assigned :course
	
	def index
		@courses = Course.all.decorate
	end

	def show
	end

	def edit
		render 'newedit'
	end

	def update
		if @course.update_attributes(course_params)
			redirect_to @course
		else
			render 'newedit'
		end
	end

	def new
		@course = Course.new
		render 'newedit'
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			redirect_to @course
		else
			render 'newedit'
		end
	end

	def destroy
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
