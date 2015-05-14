class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  has_and_belongs_to_many(:ingredients)
  validates(:title, {:presence => true})

  # private
  # def rating_sort
  #   Recipe.order(rating: asc)
  # end

end
