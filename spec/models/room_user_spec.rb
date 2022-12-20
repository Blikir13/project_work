require 'rails_helper'

RSpec.describe RoomUser, type: :model do
  describe 'Invalid RoomUser' do
    it 'Invalid wish' do
      expect { RoomUser.create!(room_id: '1', user_id: '1234', role: 'admin', wish: '', real_username: 'Ура') }.to raise_error ActiveRecord::RecordInvalid
    end
    it 'Invalid real_username' do
      expect { RoomUser.create!(room_id: '1', user_id: '1234', role: 'admin', wish: 'gsfg', real_username: '124325235') }.to raise_error ActiveRecord::RecordInvalid
    end
  end
  describe 'Correct Room' do
    it 'Correct RoomUser' do
      expect { RoomUser.create!(room_id: '1', user_id: '1234', role: 'admin', wish: 'печка', real_username: 'Юрасик')  }.not_to raise_error
    end
  end
end
