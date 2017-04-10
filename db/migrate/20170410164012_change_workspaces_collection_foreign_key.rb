class ChangeWorkspacesCollectionForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :workspaces, :collections
    add_foreign_key    :workspaces, :collections, on_delete: :nullify
  end
end
