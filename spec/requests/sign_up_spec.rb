require 'rails_helper'

RSpec.describe 'SignInWithAuthTokens', type: :request do
  let!(:attributes_for_user) { attributes_for :user }

  describe 'sign up' do
    context 'with correct data' do
      before do
        post '/api/v1/users', user: attributes_for_user, format: :json
      end

      it 'should return success' do
        expect(response).to have_http_status(200)
      end

      it 'should create user' do
        expect(User.find_by(email: attributes_for_user[:email])).to_not eq nil
      end
    end

    context 'with wrong data' do
      before do
        post '/api/v1/users', user: attributes_for_user.except(:password), format: :json
      end

      it 'should return Unprocessable Entity' do
        expect(response).to have_http_status(422)
      end

      it 'should fill error hash' do
        obj_from_json = JSON.parse response.body

        expect(obj_from_json['errors']).to be_present
      end
    end
  end
end
