require("bundler/setup")
Bundler.require(:default, :production)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @recipes = Recipe.all.order(rating: :desc)
  erb(:index)
end

get('/recipes') do
  erb(:recipes)
end

post('/recipe/new') do
  # category_id = params.fetch("categories").to_i
  # category_choice = Category.find(params.fetch("categories").to_i)
  new_recipe = Recipe.new({:title => params.fetch("title")})
  if new_recipe.save
    # category_choice.recipes.push(new_recipe)
    @recipes = Recipe.all
    redirect("/recipe/new/#{new_recipe.id}")
  else
    erb(:error)
  end
end

get('/recipe/new/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:ingredient_form)
end

patch('/recipe/new/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  new_ingredient = Ingredient.new(description: params.fetch("description"), amount: params.fetch("amount"))
  if new_ingredient.save
    @recipe.ingredients.push(new_ingredient)
    redirect("recipe/new/#{@recipe.id}")
  else
    erb(:error)
  end
end

get('/recipe/:id/instructions') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:instruction_form)
end

patch('/recipe/:id/instructions') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.update(instructions: params.fetch("instructions"))
  redirect("/recipe/#{params.fetch('id').to_i}")
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
  new_instructions = params.fetch("instructions")
  new_ingredients = params.fetch("ingredients")
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

delete('/categories') do
  category = Category.find(params.fetch("id").to_i)
  category.delete
  @all_categories = Category.all
  erb(:categories)
end

patch('/recipe_rating') do
  rating = params.fetch("add_rating").to_i
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.update({:rating => rating})
  @all_categories = Category.all()
  erb(:recipe)
end
