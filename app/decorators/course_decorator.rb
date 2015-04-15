
class CourseDecorator < Draper::Decorator
  
  delegate_all

  def panel_heading_title
  	if object.title
  		"Edit - #{object.title}"
  	else
  		"New course"
  	end
  end

  def edit_link
  	h.tag_label h.link_to("Edit" , h.edit_course_path(object)) , :success
  end

  def destroy_link remote = false
  	h.tag_label h.link_to("Delete" , h.course_path(object) , method: :delete , remote: remote,
  											data: {confirm: "Are you sure?"}) , :danger
  end

  def newLessonLink
    h.tag_label h.link_to("Add lesson", h.new_course_lesson_path(object)), :primary
  end

  def idText
  	"course#{object.id}"
  end

  def lessonsCount
    count = object.lessons.count
    if count == 0
      h.content_tag(:strong,"There is no lessons in this course")
    else
      h.content_tag(:strong,h.pluralize(count,"lesson"))
    end
  end

end
