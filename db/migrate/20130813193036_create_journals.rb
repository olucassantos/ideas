class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :adoption_id
      t.text :description
      t.timestamps
    end
  end
end
