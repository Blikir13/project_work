require 'rails_helper'

RSpec.describe History, type: :model do
  describe 'Correct History' do
    it 'create correctly History' do
      expect { History.create!(giver_id: '1', receiver_id: '32', receiver_wish: 'кресло-качалка', room_name: 'Друзья', giver_name: 'Рита', receiver_name: 'Олег') }.not_to raise_error
    end
  end
end
