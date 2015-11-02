require 'rails_helper'

RSpec.describe 'SignInWithAuthTokens', type: :request do
  let!(:user) { create :user }

  describe 'auth via token' do
    context 'correct credentials' do
      before do
        get '/api/v1/articles', user_email: user.email, user_token: user.authentication_token, format: :json
      end

      it 'should return Success' do
        expect(response).to have_http_status(200)
      end
    end

    context 'wrong credentials' do
      before do
        get '/api/v1/articles', format: :json
      end

      it 'should return Unauthorized status' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
