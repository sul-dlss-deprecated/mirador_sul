class AddPublicBooleanToWorkspaces < ActiveRecord::Migration[5.0]
  def change
    add_column :workspaces, :public, :boolean, null: false, default: false
    add_index :workspaces, :public
  end
end
