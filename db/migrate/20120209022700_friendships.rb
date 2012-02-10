class Friendships < ActiveRecord::Migration
  def change
    create_table :friendships, :id => false do |t|
    t.column :user_id, :integer, :null => false
    t.column :friend_id, :integer, :null => false
    t.timestamps
    end
  end
end
