class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :fb_id
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.integer :rank, default: 1400
      t.boolean :male

      t.timestamps
    end
  end
end
