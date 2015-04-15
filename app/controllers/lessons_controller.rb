class LessonsController < ApplicationController
	decorates_assigned :lesson
	before_filter :find_course , only: [:new,:create]
	before_filter :find_lesson , only: [:show,:edit,:update,:destroy]

	def show
	end
	
	def new
		@lesson = @course.lessons.build
	end

	def create
		@lesson = @course.lessons.create(lesson_params)
		if @lesson.save
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def edit
		render 'new'
	end

	def update
		if @lesson.update_attributes(lesson_params)
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def destroy
		@lesson.destroy
		redirect_to @course
	end

	private
		def lesson_params
			params.require(:lesson).permit(:title,:description,:content)
		end

		def find_course
			@course = Course.find(params[:course_id])
		end

		def find_lesson
			find_course
			@lesson = @course.lessons.find(params[:id])
		end
end
