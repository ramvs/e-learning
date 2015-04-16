class QuestionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
	def form_title
	  	if model.id
	  		"Editing question"
	  	else
	  		"Add new question"
	  	end
  	end

  def destroy_link remote=false
    	h.tag_label h.link_to("Delete" , h.test_question_path(object.test,object) , 
                        method: :delete , remote: remote,
                        data: {confirm: "Are you sure?"}) , :danger
	end

	def edit_link
		h.tag_label h.link_to("Edit" , h.edit_test_question_path(object.test,object)) , :success
	end

  def simple_show_link
    h.link_to model.content , h.test_question_path(object.test,object)
  end

  def renderAnserws
    if model.anserws.any?
      h.content_tag(:ul, h.render(AnserwDecorator.decorate_collection model.anserws),
        class: "list-grup")
    else
      h.content_tag(:strong,"No anserws found")
    end
  end

end
