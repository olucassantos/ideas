class CategoryTheory < ActiveRecord::Migration
  def self.up
    create_table :categories_theories, id: false do |t|
        t.references :category
        t.references :theory
      end
      add_index :categories_theories, :theory_id
      add_index :categories_theories, :category_id
      add_index :categories_theories, [:category_id, :theory_id]
  end

  def down
    drop_table :categories_theories
  end
end
