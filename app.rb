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
  new_recipe = Recipe.create({:title => params.fetch("title"), :ingredients => params.fetch("ingredients"), :instructions => params.fetch("instructions")})
  category_choice.recipes.push(new_recipe)
  @recipes = Recipe.all
  erb(:index)
end

get('/categories') do
  @all_categories = Category.all
  erb(:categories)
end

post('/categories') do
  Category.create({:name => params.fetch("category_input")})
  @all_categories = Category.all
  erb(:categories)
end
