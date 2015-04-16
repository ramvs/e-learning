class TestDecorator < Draper::Decorator
	delegate_all

	def show_link
    h.tag_label h.link_to("Show test", h.lesson_test_path(object.lesson,object)) , :success
	end

  def simple_show_link
    h.link_to model.title , [model.lesson,model]
  end

  def lesson_link
    model.lesson.decorate.show_link
  end

	def destroy_link remote=false
    if h.can? :destroy , model
      h.tag_label h.link_to("Delete" , h.lesson_test_path(object.lesson,object) , 
                        method: :delete , remote: remote,
                        data: {confirm: "Are you sure?"}) , :danger
    end
	end

	def edit_link
    if h.can? :update , model
  	 h.tag_label h.link_to("Edit" , h.edit_lesson_test_path(object.lesson,object)) , :success
    end
	end

  def show_description
    if model.description && model.description!=""
      model.description
    else
      "No description available"
    end
  end

  def manage_questions_link
    if h.can? :update , model
      h.tag_label h.link_to("Manage questions",h.test_questions_path(model)) , :primary
    end
  end

  def add_question_link remote=false
    if h.can? :update , model
      h.tag_label h.link_to("Add question",h.new_test_question_path(model)) , :primary
    end
  end

  def render_questions
    if model.questions.any?
      h.content_tag :ul , (h.render QuestionDecorator.decorate_collection(model.questions)) ,
                class: "list-group"
    else
      "No questions in the test"
    end
  end

end
