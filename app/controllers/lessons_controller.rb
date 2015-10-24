class LessonsController < ApplicationController
	decorates_assigned :lesson
	before_filter :find_course , only: [:new,:create]
	before_filter :find_lesson , only: [:show,:edit,:update,:destroy]

	def show
		authorize! :read , @lesson
		@documents = @lesson.documents.where("attached_doc is NOT NULL")
	end
	
	def new
		authorize! :create , Lesson
		authorize! :update , @course
		@lesson = @course.lessons.build
	end

	def create
		authorize! :create , Lesson
		authorize! :update , @course
		@lesson = @course.lessons.create(lesson_params)
		if @lesson.save
			redirect_to [@lesson.course,@lesson], flash: {notice:  "Lesson created."}
		else
			render 'new'
		end
	end

	def edit
		authorize! :update , @lesson
		authorize! :update , @course
		render 'new'
	end

	def update
		authorize! :update , @lesson
		authorize! :update , @course
		if @lesson.update_attributes(lesson_params)
			redirect_to [@lesson.course,@lesson], flash: {notice:  "Lesson updated."}
		else
			render 'new'
		end
	end

	def destroy
		authorize! :destroy , @lesson
		authorize! :update , @course
		result = @lesson.destroy
		respond_to do |format|
			format.html {redirect_to @course, flash: {danger:  "Lesson destroyed."} }
			format.js { @id = result ? result.id : "" }
		end
	end

	private
		def lesson_params
			params.require(:lesson).permit(:title,:description,:content,:extern_video_url)
		end

		def find_course
			@course = Course.find(params[:course_id])
		end

		def find_lesson
			find_course
			@lesson = @course.lessons.find(params[:id])
		end
end
