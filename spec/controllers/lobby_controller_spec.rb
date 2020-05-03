require 'rails_helper'

RSpec.describe LobbyController do
  describe 'GET show' do
    context 'an authenticated UserSession exists' do
      before do
        @user = create(:user)

        @token = JWT.encode(
          {
            user_id: @user.id,
            exp: 24.hours.from_now.to_i
          },
          Rails.application.secrets.secret_key_base
        )
      end

      it 'returns a success message' do
        request.headers['Authorization'] = @token

        get :show

        expect(response.body).to eq({ message: 'yay' }.to_json)
      end

      it 'produces a 200 status code' do
        request.headers['Authorization'] = @token

        get :show

        expect(response.status).to eq(200)
      end
    end

    context 'no authenticated UserSession exists' do
      it 'returns a failure message' do
        get :show

        expect(response.body).to eq({ message: 'missing token' }.to_json)
      end

      it 'produces a 403 error status code' do
        get :show

        expect(response.status).to eq(403)
      end
    end
  end
end