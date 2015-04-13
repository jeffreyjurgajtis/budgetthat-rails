require "rails_helper"

describe V1::SessionsController do
  describe 'POST create' do
    let(:password) { 'password' }
    let!(:user) { create(:user, password: password) }

    context 'created' do
      it 'returns status 201' do
        post :create, session: { email: user.email, password: password }
        expect(response).to have_http_status 201
      end

      it 'returns user JSON' do
        post :create, session: { email: user.email, password: password }
        expect(json['user']).to be_present
      end
    end

    context 'bad request' do
      it 'returns status 400' do
        post :create, session: { email: user.email, password: 'invalid' }
        expect(response).to have_http_status 400
      end

      it 'returns errors' do
        post :create, session: { email: user.email, password: 'invalid' }
        expect(json['errors']).to be_present
      end
    end
  end
end

