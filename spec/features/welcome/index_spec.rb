require 'rails_helper'

RSpec.describe 'landing page' do
  before :each do
    visit root_path
  end

  it 'has the title of the application' do
    expect(page).to have_content("Viewing Party Lite")
  end

  it 'has a button to create a new user' do
    click_button("Create User")

    expect(current_path).to eq(new_user_path)
  end

  it 'list of Existing Users which links to the users dashboard' do
    user1 = User.create!(email: "john@email.com", name: "John Cena", password: "pass123")
    user2 = User.create!(email: "Phil@email.com", name: "Phil Jones", password: "pass123")
    visit login_path
    fill_in :email, with: user1.email
    fill_in :password, with: user1.password
    click_button "Login"

    visit root_path

    within "div#user_#{user1.id}" do
      expect(page).to have_content(user1.email)
    end

    within "div#user_#{user2.id}" do
      expect(page).to have_content(user2.email)
    end
  end

  it 'has a link to go back to the landing page' do
    expect(page).to have_link("Home", href: root_path)
  end
end
