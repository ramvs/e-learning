class DocumentsController < ApplicationController
	before_filter :find_lesson , only: [:new,:create]
	before_filter :find_document , only: [:edit,:update,:destroy]
	def new
		@document = @lesson.documents.build
	end

	def create
		@document = @lesson.documents.create document_params
		if @document.save
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def edit
		render 'new'
	end

	def update
		if @document.update_attributes(document_params)
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def destroy
		@document.destroy
		redirect_to [@lesson.course,@lesson]
	end

	private
		def find_lesson
			@lesson = Lesson.find(params[:lesson_id])
		end

		def find_document
			find_lesson
			@document = @lesson.documents.find(params[:id])
		end

		def document_params
			params.require(:document).permit(:title,:attached_doc)
		end
end
