class AddsIngredientTable < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |t|
      t.column(:description, :string)
      t.column(:amount, :string)
    end
    create_table(:ingredients_recipes) do |t|
      t.belongs_to :ingredients, index: true
      t.belongs_to :recipes, index: true
    end
  end
end
