class DocumentsController < ApplicationController
	before_filter :find_lesson , only: [:new,:create]
	before_filter :find_document , only: [:edit,:update,:destroy]

	def new
		@document = @lesson.documents.build
		authorize! :create , Document
		authorize! :update, @lesson
	end

	def create
		authorize! :create , Document
		authorize! :update, @lesson
		@document = @lesson.documents.create document_params
		if @document.save
			@document.create_activity key: 'document.create', owner: current_user
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def edit
		authorize! :update, @lesson
		render 'new'
	end

	def update
		authorize! :update, @lesson
		if @document.update_attributes(document_params)
			@document.create_activity key: 'document.update', owner: current_user
			redirect_to [@lesson.course,@lesson]
		else
			render 'new'
		end
	end

	def destroy
		authorize! :update, @lesson
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
