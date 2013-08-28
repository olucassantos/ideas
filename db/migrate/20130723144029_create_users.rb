class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit:  200, :null => false
      t.string :email, limit:  200, :null => false
      t.string :code, limit:  255, :null => true
      t.boolean :tested, null: true
      t.string :phone, limit: 12 , :null => true
      t.date :age, null:  true
      t.text :about, null:  true
      t.boolean :admin, null:  true
      t.string :token, null: true

      t.timestamps
    end
  end
end
