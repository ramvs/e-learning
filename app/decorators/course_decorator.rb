
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
  	h.link_to "Edit" , h.edit_course_path(object)
  end

  def destroy_link remote = false
  	h.link_to "Delete" , h.course_path(object) , method: :delete , remote: remote,
  											data: {confirm: "Are you sure?"}
  end

  def idText
  	"course#{object.id}"
  end

end
