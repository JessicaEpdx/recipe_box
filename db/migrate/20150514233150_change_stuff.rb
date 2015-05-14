class ChangeStuff < ActiveRecord::Migration
  def change
    drop_table(:ingredients_recipes)
    create_table(:ingredients_recipes) do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :recipe, index: true
    end
  end
end
