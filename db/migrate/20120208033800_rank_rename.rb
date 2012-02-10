class RankRename < ActiveRecord::Migration
  def change
    rename_column :users, :rank, :rating
  end
end
