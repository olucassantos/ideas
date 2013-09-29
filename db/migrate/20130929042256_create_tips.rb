class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :title, null: false
      t.string :tags, null: false
      t.text :description, null: false
      t.text :brief, null: false
      t.integer :user_id, null: false
      t.integer :view, null: true
      t.timestamps
    end
    add_index :tips, :user_id
  end
end
