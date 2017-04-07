class AddCounterCacheToCollections < ActiveRecord::Migration[5.0]
  def change
    change_table :collections do |t|
      t.integer :workspaces_count, default: 0
    end
  end
end
