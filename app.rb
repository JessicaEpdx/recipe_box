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
