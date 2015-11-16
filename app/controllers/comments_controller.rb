class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = @course.comments.build
  end

  def edit
  end

  def create
    @course = Course.find(params[:course_id])
    @comment = @course.comments.create(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        @comment.create_activity key: 'comment.create', owner: current_user
        format.html { redirect_to @course, notice: 'Comment was successfully created.' }
        format.json { redirect_to @course }
      else
        format.html { render :new }
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:description, :course_id, :lesson_id, :user_id)
    end
end
