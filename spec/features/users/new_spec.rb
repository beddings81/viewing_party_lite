require 'rails_helper'

RSpec.describe "New User Page" do
  before :each do
    visit new_user_path
  end

  it 'contains a form to create a new user and redirects to their show page' do
    fill_in "Name", with: "John Cena"
    fill_in "Email", with: "youcantseeme@email.com"
    fill_in "Password", with: "Test123"
    fill_in "password_confirmation", with: "Test123"
    click_button "Submit"
    
    expect(current_path).to eq(root_path)
  end

  it 'will not create a user if the password and password confirmation do not match' do
    fill_in "Name", with: "John Cena"
    fill_in "Email", with: "youcantseeme@email.com"
    fill_in "Password", with: "Test123"
    fill_in "password_confirmation", with: "Test"
    click_button "Submit"
    
    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Passwords must match!")
  end

  it 'will not accept a user name already in the system' do
    user = User.create!(name: "Bob", email: "bob@email.com", password: "test123")
    visit new_user_path

    fill_in "Name", with: "John Cena"
    fill_in "Email", with: "bob@email.com"
    click_button "Submit"

    expect(page).to have_content("Error: All fields must be complete and email must be unique")
    expect(current_path).to eq(new_user_path)
  end

  it 'form requires all fields to be filled' do
    fill_in "Name", with: ""
    fill_in "Email", with: "bob@email.com"
    click_button "Submit"

    expect(page).to have_content("Error: All fields must be complete and email must be unique")
    expect(current_path).to eq(new_user_path)
  end
end