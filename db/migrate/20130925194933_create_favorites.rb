class CreateFavorites < ActiveRecord::Migration
	def up
    create_table :favorites do |t|
      t.boolean :check, null: false
      t.integer :user_id, null: false
      t.integer :theory_id, null: false

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :theory_id
  end

  def down
    drop_table :favorites
  end
end
