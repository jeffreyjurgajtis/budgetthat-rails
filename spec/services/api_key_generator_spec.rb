require "rails_helper"

describe ApiKeyGenerator do
  describe '#first_or_create' do
    let!(:user) { create :user }

    before { Timecop.freeze }
    after  { Timecop.return }

    context 'when an active key exists' do
      let!(:api_key) { create(:api_key,
                              user_id: user.id,
                              expired_at: 2.hours.from_now) }

      it 'returns the existing api key' do
        result = ApiKeyGenerator.new(user.id).first_or_create
        expect(result).to eq api_key
      end
    end

    context 'when no active key exists' do
      before { create :api_key, user_id: user.id, expired_at: 10.hours.ago }

      it 'returns a new api key' do
        expect do
          ApiKeyGenerator.new(user.id).first_or_create
        end.to change { ApiKey.count }.by 1
      end

      it 'sets expired at' do
        result = ApiKeyGenerator.new(user.id).first_or_create
        expect(result.expired_at).to eq ApiKey::TIME_TO_LIVE.from_now
      end

      it 'sets access token' do
        result = ApiKeyGenerator.new(user.id).first_or_create
        expect(result.access_token =~ /\S{32}/).to be
      end
    end
  end
end
