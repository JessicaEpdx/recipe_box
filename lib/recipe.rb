class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  validates(:title, {:presence => true})
  validates(:ingredients, {:presence => true})
  validates(:instructions, {:presence => true})
end
