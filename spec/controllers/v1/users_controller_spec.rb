require "rails_helper"

describe V1::UsersController do
  describe 'POST create' do
    let(:email) { 'email@example.com' }

    context 'created' do
      let(:user_params) do
        {
          email: email,
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'returns status 201' do
        post :create, user: user_params
        expect(response).to have_http_status 201
      end

      it 'returns user JSON' do
        post :create, user: user_params
        expect(json['user']).to be_present
      end

      it 'returns an access token' do
        post :create, user: user_params
        expect(json['user']['access_token']).to be_present
      end
    end

    context 'bad request' do
      let(:user_params) do
        {
          email: email,
          password: 'password',
          password_confirmation: 'mismatch'
        }
      end

      it 'returns status 400' do
        post :create, user: user_params
        expect(response).to have_http_status 400
      end

      it 'returns errors' do
        post :create, user: user_params
        expect(json['errors']).to be_present
      end
    end
  end
end

