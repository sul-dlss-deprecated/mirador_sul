class CreateJoinTableCollectionManifest < ActiveRecord::Migration[5.0]
  def change
    create_join_table :collections, :manifests do |t|
      t.references :collection, index: true, foreign_key: true
      t.references :manifest, index: true, foreign_key: true
      t.index [:collection_id, :manifest_id]
    end
  end
end
