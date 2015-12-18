class AddRememberDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_digest, :string
    #remember_digest automatically created by ActiveRecord when user is added 
  end
end
