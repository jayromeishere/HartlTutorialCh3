class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :microposts, [:user_id, :created_at]
    # makes queries to find a user's microposts easier by loading less into memory
  end
end
