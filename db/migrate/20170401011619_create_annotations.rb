class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :user, foreign_key: true
      t.string :uuid
      t.string :canvas
      t.binary :data

      t.timestamps
    end
    add_index :annotations, :uuid
    add_index :annotations, :canvas
  end
end
