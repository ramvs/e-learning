
class CourseDecorator < Draper::Decorator
  decorates_association :lessons 
  delegate_all

  def panel_heading_title
  	if object.title
  		"Edit - #{object.title}"
  	else
  		"New course"
  	end
  end

  def edit_link
  	if h.can? :update , model
      h.tag_label h.link_to("Edit" , h.edit_course_path(object)) , :success
    end
  end

  def destroy_link remote = false
  	if h.can? :destroy , model
      h.tag_label h.link_to("Delete" , h.course_path(object) , method: :delete , remote: remote,
    											data: {confirm: "Are you sure?"}) , :danger
    end
  end

  def newLessonLink
    if h.can?(:create,Lesson) && h.can?(:update,model)
      h.tag_label h.link_to("Add lesson", h.new_course_lesson_path(object)), :primary
    end
  end

  def idText
  	"course#{object.id}"
  end

  def lessonsCount
      count = model.lessons.count
      h.badge(h.pluralize(count,"lesson"),:primary)
  end

  def renderLessons
      if model.lessons.any?
        h.content_tag(:ul, h.render(LessonDecorator.decorate_collection(model.lessons)),
          class: "list-group")
      else
        h.content_tag(:strong,"No lessons in this course")
      end
  end

end
