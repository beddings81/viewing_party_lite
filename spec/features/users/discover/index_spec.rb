require 'rails_helper'

RSpec.describe "The Discover Movies Page" do
  before :each do
    @user = User.create!(name: "John Cena", email: "johnc@email.com", password: "pass123")
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Login"
  end

  it 'is accessed from a button on a users show page' do
    click_button "Discover Movies"

    expect(current_path).to eq(discover_index_path)
  end

  it 'has a button to discover top rated movies' do
    visit discover_index_path

    expect(page).to have_button("Top Rated Movies")
  end

  it 'has a text field to enter keywords to search by movie title and search button' do
    visit discover_index_path

    expect(page).to have_field(:movie_search)
    expect(page).to have_button("Search")
  end
end