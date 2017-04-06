class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :workspace, foreign_key: true
      t.string :uuid
      t.binary :data

      t.timestamps
    end
    add_index :annotations, :uuid
  end
end
