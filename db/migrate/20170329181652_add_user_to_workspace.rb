class AddUserToWorkspace < ActiveRecord::Migration[5.0]
  def change
    add_column :workspaces, :user_id, :integer
    add_index :workspaces, :user_id
  end
end
