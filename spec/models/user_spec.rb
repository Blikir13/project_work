require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Invalid User' do
    it 'Unique of User' do
      User.create!(username: 'testuser', password_digest: '1234', user_mail: 'testuser@user.com')
      expect { User.create!(username: 'testuser', password_digest: '1234', user_mail: 'testuser@user.com') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid username' do
      expect { User.create!(username: '', password_digest: '1234', user_mail: 'testuser@user.com') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid password' do
      expect { User.create!(username: 'testuser', password_digest: '', user_mail: 'testuser@user.com') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid mail' do
      expect { User.create!(username: 'testuser', password_digest: '1234', user_mail: 'testuser') }.to raise_error ActiveRecord::RecordInvalid
    end
  end
  describe 'Correct Room' do
    it 'Correct Room' do
      expect { User.create!(username: 'testuser', password_digest: '1234', user_mail: 'testuser@user.com') }.not_to raise_error
    end
  end
end
