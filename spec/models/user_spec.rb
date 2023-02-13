require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password}

    it 'should hash a users password' do
      user = User.create(name: 'Braxton', email: 'b@test.com', password: 'password123', password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end

  describe 'associations' do
    it {should have_many(:invitees)}
    it {should have_many(:viewing_parties).through(:invitees)}
  end

  describe '#host?' do
    it 'returns true if user is host of given vp, false otherwise' do
      user = User.create!(name: "John Cena", email: "John@email.com", password: "Test123", password_confirmation: "Test123")
      viewing_party1 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party1.id, host: true)
      viewing_party2 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party2.id, host: false)

      expect(user.host?(viewing_party1.id)).to eq(true)
      expect(user.host?(viewing_party2.id)).to eq(false)
    end
  end

  describe '#hosting_viewing_parties' do
    it 'returns an array of all vps that the user is hosting' do
      user = User.create!(name: "John Cena", email: "John@email.com", password: "Test123", password_confirmation: "Test123")
      viewing_party1 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party1.id, host: true)
      viewing_party2 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party2.id, host: false)

      expect(user.hosting_viewing_parties).to eq([viewing_party1])
    end
  end

  describe '#not_hosting_viewing_parties' do
    it 'returns an array of all vps that the user is not hosting' do
      user = User.create!(name: "John Cena", email: "John@email.com", password: "Test123", password_confirmation: "Test123")
      viewing_party1 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party1.id, host: true)
      viewing_party2 = ViewingParty.create!(when: "11/21/2030 7:00", duration: 90, start_time: "7:00", movie_id: 550)
      Invitee.create!(user_id: user.id, viewing_party_id: viewing_party2.id, host: false)

      expect(user.not_hosting_viewing_parties).to eq([viewing_party2])
    end
  end
end