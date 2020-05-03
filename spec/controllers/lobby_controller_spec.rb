require 'rails_helper'

RSpec.describe LobbyController do
  describe 'GET show' do
    context 'an authenticated UserSession exists' do
      before do
        @user_session = create(:user_session)
      end

      it 'returns a success message' do
        get :show, params: { token: @user_session.token }
        expect(response.body).to eq({ message: 'yay' }.to_json)
      end

      it 'produces a 200 status code' do
        get :show, params: { token: @user_session.token }
        expect(response.status).to eq(200)
      end
    end

    context 'no authenticated UserSession exists' do
      it 'returns a failure message' do
        get :show, params: { token: '123' }
        expect(response.body).to eq({ message: 'nay' }.to_json)
      end

      it 'produces a 403 error status code' do
        get :show, params: { token: '123' }
        expect(response.status).to eq(403)
      end
    end
  end
end