class StaticPagesController < ApplicationController
  def home
  	@courses = Course.all
  	@lessons = Lesson.all.count
  end
end
