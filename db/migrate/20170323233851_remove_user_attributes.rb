class RemoveUserAttributes < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :password_digest, :string
    remove_index :users, :email
    remove_column :users, :email, :string
  end
end
