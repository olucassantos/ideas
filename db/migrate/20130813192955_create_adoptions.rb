class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.integer :theory_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
