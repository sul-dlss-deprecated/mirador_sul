class CreateWorkspaces < ActiveRecord::Migration[5.0]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.binary :data, limit: 64000
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
