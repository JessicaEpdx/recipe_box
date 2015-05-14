require('spec_helper')


describe Recipe do
  describe('recipe form path', :type => :feature) do
    it('will add a recipe when you submit recipe form') do
      visit('/recipes')
      fill_in('title', :with => 'TitleInput')
      fill_in('ingredients', :with => 'Ingredients')
      fill_in('instructions', :with => 'Instructions')
      click_button('Add this Recipe into the box!')
      expect(page).to have_content('TitleInput')
    end
  end
end
