require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "a", email: "a@email.com", password: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Login"

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome, #{user.email}!")
    expect(page).to have_content("#{user.name}'s Dashboard")
  end

  it "cannot log in with bad credentials" do
    user = User.create!(name: "a", email: "a@email.com", password: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "1"

    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your password does not match.")
  end
end