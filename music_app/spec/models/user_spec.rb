require 'rails_helper'

RSpec.describe User, type: :model do
  FactoryBot.define do
  factory :user do # The name matters. :cat factory returns a Cat object.
    email: 'eml@email.com'
    password: 'password'
  end
end
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:session_token)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_length_of(:password)}

  describe 'is_password?' do  
    it 'should return true for correct passwords' do
      let(:password_digest) { BCrypt::Password.create('password')}
      expect(password_digest.is_password?('password')).to be true
    end
    it 'should return false for incorrect passwords' do
      let(:password_digest) { BCrypt::Password.create('password')}
      expect(password_digest.is_password?('password1')).to be true
    end

  end

  describe 'reset_session_token' do
     
    it 'should change the session token' do
      expect(user.password_token).not_to eq(user.reset_session_token!)
    end
    it 'should return a new session token' do
      expect(user.reset_session_token).to eq (user.session_token)
    end

  end

  describe 'find_by_credentials' do 
    before { user.save! }
    it 'should return a user if credentials are valid' do
      expect(User.find_by_credentials('eml@email.com', 'password')).to eq (user)
    end

    it 'should return nil if credentials are not valid' do
      expect(User.find_by_credentials('com', 'pw')).to be nil
    end
  end



end
