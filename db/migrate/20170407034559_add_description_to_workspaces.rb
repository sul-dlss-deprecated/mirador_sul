class AddDescriptionToWorkspaces < ActiveRecord::Migration[5.0]
  def change
    add_column :workspaces, :description, :text
  end
end
