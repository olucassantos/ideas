class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :point
      t.integer :user_id
      t.integer :theory_id
      t.integer :tip_id
      t.timestamps
    end
  end
end
