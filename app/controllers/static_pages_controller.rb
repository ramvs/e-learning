class StaticPagesController < ApplicationController
  include PublicActivity

  def home
  	@courses = Course.all
  	@lessons = Lesson.all.count
    @activities = Activity.all.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end
end
