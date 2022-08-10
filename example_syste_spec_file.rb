require 'rails_helper'

RSpec.describe 'Food management function', type: :system do
  before do
    @food = Food.create!( id:1, name: 'rice', description: 'white rice', price: '2000' )
  end

  describe "Function to publish a new food" do
      it "The created food is displayed" do

        visit "/foods/new"
        fill_in "food[name]", with: 'Riz au gras'
        fill_in "food[description]", with: "De chez nous"
        fill_in "food[price]", with: "2000"
        click_button 'Create a Food'

        click_on 'Back'

       expect(page).to have_content 'Riz au gras'
      end
 end
  
  describe "Function to display the list of foods" do
      it "The created foods are displayed" do

        FactoryBot.create(:food)
        visit foods_path
        
        expect(page).to have_content 'Food'
      end
 end

#*******************************************************************************#

  describe "Food detail display function" do
     context "Food detail screen" do
       it "Ability to display the food contents" do

          food = FactoryBot.create(:food)

          visit food_path(food.id)

        expect(page).to have_content 'Food'
       end
     end
  end

#*******************************************************************************#

    describe 'Content deletion function' do
       context "transitioning to the food list screen after deleting a food" do
         it "Possibility to delete a content" do

            visit '/foods/new'
            fill_in "food[name]", with: 'Pate'
            fill_in "food[description]", with: "Locale"
            fill_in "food[price]", with: "2500"
            click_button 'Create a Food'

              click_on 'back'

              click_on "Delete"
                a = page.driver.browser.switch_to.alert
                a.accept
            expect(page).to have_content 'Food'
         end
       end
    end
end
