class RedoJoinTable < ActiveRecord::Migration
  def change
    drop_table(:categories_recipes)
    create_table(:categories_recipes) do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :category, index: true
    end
  end
end
