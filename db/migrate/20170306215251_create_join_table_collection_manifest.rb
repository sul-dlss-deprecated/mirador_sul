class CreateJoinTableCollectionManifest < ActiveRecord::Migration[5.0]
  def change
    create_join_table :collections, :manifests, column_options: { foreign_key: true, index: true }
  end
end
