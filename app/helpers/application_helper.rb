module ApplicationHelper
  def in_edit_mode
    action_name == 'edit'
  end
end
