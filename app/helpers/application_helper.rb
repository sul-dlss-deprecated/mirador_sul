module ApplicationHelper
  def in_edit_mode
    action_name == 'edit'
  end

  def mirador_options(workspace: @workspace)
    MiradorOptionsJson.new(workspace: workspace).to_json
  end
end
