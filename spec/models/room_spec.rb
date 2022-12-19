require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'Invalid Room' do
    it 'Unique of room_name' do
      Room.create!(room_name: '1', password_digest: '1234', count_of_users: '11')
      expect { Room.create!(room_name: '1', password_digest: '1234', count_of_users: '11') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid count of users' do
      expect { Room.create!(room_name: '1', password_digest: '1234', count_of_users: '-11') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid password' do
      expect { Room.create!(room_name: '1', password_digest: '', count_of_users: '33') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid room_name' do
      expect { Room.create!(room_name: '', password_digest: '1234', count_of_users: '11') }.to raise_error ActiveRecord::RecordInvalid
    end
  end
  describe 'Correct Room' do
    it 'Correct Room' do
      expect { Room.create!(room_name: '1', password_digest: '1234', count_of_users: '11') }.not_to raise_error
    end
  end
end
