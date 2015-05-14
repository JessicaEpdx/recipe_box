require('spec_helper')

describe Recipe do
  it('ensures the recipe has a title') do
    recipe = Recipe.new({:title => "", :ingredients => "things", :instructions => "do stuff"})
    expect(recipe.save()).to(eq(false))
  end

  it('ensures the recipe has ingredients') do
    recipe = Recipe.new({:title => "cake", :ingredients => "", :instructions => "do stuff"})
    expect(recipe.save()).to(eq(false))
  end

end
