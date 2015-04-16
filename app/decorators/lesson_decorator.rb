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
    if h.can? :update , model
      h.tag_label h.link_to("Edit" , h.edit_course_lesson_path(object.course,object)) , :success
    end
  end

  def destroy_link remote = false
    if h.can? :destroy , model
      h.tag_label h.link_to("Delete" , h.course_lesson_path(object.course,object) , 
                          method: :delete , remote: remote,
                          data: {confirm: "Are you sure?"}) , :danger
    end
  end

  def idText
    "lesson#{model.id}"
  end

  def showTestLink
    if model.test
      model.test.decorate.show_link
    elsif h.can?(:update,model)
      h.tag_label h.link_to("Add test", h.new_lesson_test_path(model)),:primary
    else
      "No test"
    end
  end

  def destroyTestLink remote=false
    if model.test && h.can?(:update , model)
       model.test.decorate.destroy_link(remote)
    end
  end

  def editTestLink 
    if model.test && h.can?(:update,model)
      model.test.decorate.edit_link
    end
  end

  def show_description
    if model.description && model.description!=""
      model.description
    else
      "No descriptin for this lessson"
    end
  end

  def render_documents
    if model.documents.any?
      h.content_tag(:ul, h.render(DocumentDecorator.decorate_collection(model.documents)),
        class: "list-group")
    else
      "No attached documents"
    end
  end

  def add_document_link
    if h.can? :update, model
      h.tag_label h.link_to("Add document" , h.new_lesson_document_path(object)) , :success
    end
  end


end
