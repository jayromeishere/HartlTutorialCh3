class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
  end
  # this index is added to speed up lookups and to prevent duplicates
  # of users with the same email address
end
