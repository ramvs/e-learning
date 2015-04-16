class AnserwDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def get_class
  	if correct
  		"list-group-item list-group-item-success"
  	else
  		"list-group-item list-group-item-danger"
  	end
  end

end
