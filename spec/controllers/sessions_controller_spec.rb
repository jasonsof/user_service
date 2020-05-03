require 'rails_helper'

RSpec.describe SessionsController do
  describe 'POST create' do
    context 'no User with the provided email address exists' do
      it 'produces a 404 error status code' do
        post :create, params: { email: 'no@nope.com', password: '123' }
        expect(response.status).to eq(404)
      end
    end

    context 'a User with the provided email address does exist' do
      before do
        @user = create(:user)
      end

      context 'password paramter is incorrect' do
        it 'produces a 401 error status code' do
          post :create, params: { email: @user.email, password: '123' }
          expect(response.status).to eq(401)
        end

        it 'returns an empty token' do
          post :create, params: { email: @user.email, password: '123' }
          expect(response.body).to eq({ token: nil }.to_json)
        end
      end

      context 'password paramter is correct' do
        it 'produces a 200 status code' do
          post :create, params: { email: @user.email, password: @user.password }
          expect(response.status).to eq(200)
        end

        it 'returns a UserSession token' do
          post :create, params: { email: @user.email, password: @user.password }
          expect(response.body).to eq({ token: UserSession.first.token }.to_json)
        end
      end
    end
  end
end