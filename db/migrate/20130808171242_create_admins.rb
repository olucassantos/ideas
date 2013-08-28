class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name ,  :limit => 255, :null => false
      t.string :email ,  :limit => 255, :null => false
      t.string :code  ,  :limit => 255, :null => false
      t.string :phone, :limit => 12 , :null => false
      t.date :age , :null => false
      t.boolean :status, :null => true

      t.timestamps
    end
  end
end
