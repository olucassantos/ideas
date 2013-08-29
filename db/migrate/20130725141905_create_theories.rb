#encoding: utf-8
class CreateTheories < ActiveRecord::Migration
  def change
    create_table :theories do |t|
      t.string :title, :null=>false
      t.text :description, :null=>false
      t.text :justification
      t.text :brief, :null=>false
      t.decimal :outlay , :precision => 10, :scale => 2
      t.boolean :choice, :null=>false
      t.boolean :kind, :null=>false
      t.integer :user_id, :null => false
      t.integer :view, :null => true
      t.timestamps
    end
  end
end
