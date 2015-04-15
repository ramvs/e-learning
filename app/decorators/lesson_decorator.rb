class LessonDecorator < Draper::Decorator
  delegate_all
  decorates :lesson
  decorates_association  :test

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

  def show_link
    h.link_to(object.title , [object.course,object])
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

  def showTestLink
    if model.test
      model.test.decorate.show_link
    else
      h.tag_label h.link_to("Add test", h.new_lesson_test_path(model)),:primary
    end
  end

  def destroyTestLink remote=false
    if model.test
       model.test.decorate.destroy_link(remote)
    end
  end

  def editTestLink 
    if model.test
      model.test.decorate.edit_link
    end
  end


end
