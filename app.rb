require("bundler/setup")
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all
  erb(:index)
end

get('/recipes') do
  @all_categories = Category.all
  @recipes = Recipe.all
  erb(:recipes)
end

post('/recipes') do
  category_id = params.fetch("categories").to_i
  category_choice = Category.find(params.fetch("categories").to_i)
  new_recipe = Recipe.new({:title => params.fetch("title"), :ingredients => params.fetch("ingredients"), :instructions => params.fetch("instructions")})
  if new_recipe.save
    category_choice.recipes.push(new_recipe)
    @recipes = Recipe.all
    redirect('/')
  else
    erb(:error)
  end

end

get('/categories') do
  @all_categories = Category.all
  erb(:categories)
end

post('/categories') do
  new_category = Category.new({:name => params.fetch("category")})
  if new_category.save
    @all_categories = Category.all
    redirect('/categories')
  else
    erb(:error)
  end
end

get('/category/:id') do
  @category = Category.find(params.fetch("id").to_i)
  @recipes = @category.recipes
  erb(:category)
end

get('/recipe/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @all_categories = Category.all
  erb(:recipe)
end

delete('/') do
  recipe = Recipe.find(params.fetch("id").to_i)
  recipe.delete()
  @recipes = Recipe.all
  erb(:index)
end

patch('/recipe/:id') do
  @all_categories = Category.all
  new_title = params.fetch("title")
  new_ingredients = params.fetch("ingredients")
  new_instructions = params.fetch("instructions")
  category_delete = params.fetch("categories")
  if params.fetch("add_cat")
    category_add = params.fetch("add_cat")
  end
  @recipe = Recipe.find(params.fetch("id").to_i)
  if new_title.!=("")
    @recipe.update(title: new_title)
  end

  if new_ingredients.!=("")
    @recipe.update(ingredients: new_ingredients)
  end

  if new_instructions.!=("")
    @recipe.update(instructions: new_instructions)
  end

  if category_delete.!=("")
    @recipe.categories.destroy(Category.find(category_delete.to_i))
  end

  if category_add.!=("")
    category_to_add = Category.find(category_add.to_i)
    category_to_add.recipes.push(@recipe)
  end
  erb(:recipe)
end
