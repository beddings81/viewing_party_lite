require "rails_helper"

describe "Admin login" do
  describe "happy path" do
    it "I can log in as an admin and get to my dashboard" do
	    admin = User.create!(name: "admin", email: "admin@email.com", password: "admin123", role: 1)
	    user1 = User.create!(name: "Kate", email: "k@awesome-site.com", password: "admin123")
	    user2 = User.create!(name: "Blaire", email: "b@awesome-site.com", password: "admin123")

      visit login_path
      fill_in :email, with: admin.email
      fill_in :password, with: admin.password
      click_button 'Login'

      
      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end