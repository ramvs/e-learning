class LessonDecorator < Draper::Decorator
  delegate_all
  decorates :lesson

  def courseLink
  	h.link_to object.courseTitle , object.course 
  end

  def formTitle suffix=false
  	if object.title
  		h.content_tag(:span,"Editing '#{object.title}' lesson"+(suffix ? " in ": ""))
  	else
  		h.content_tag(:span,"Adding new lesson" + (suffix ? " to ": ""))
  	end
  end

  def edit_link
    h.tag_label h.link_to("Edit" , h.edit_course_lesson_path(object.course,object)) , :success
  end

  def destroy_link remote = false
    h.tag_label h.link_to("Delete" , h.course_lesson_path(object.course,object) , 
                          method: :delete , remote: remote,
                          data: {confirm: "Are you sure?"}) , :danger
  end

  def idText
    "lesson#{model.id}"
  end

end
