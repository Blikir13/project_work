require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /input' do
    it 'returns http success' do
      get '/search/input'
      expect(response).to redirect_to(session_login_url)
    end
  end
end
