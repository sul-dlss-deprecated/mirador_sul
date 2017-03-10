class CreateManifests < ActiveRecord::Migration[5.0]
  def change
    create_table :manifests do |t|
      t.string :url, limit: 4000
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
