require 'rails_helper.rb'

RSpec.describe ApplicationController, type: :controller do

  controller do
    def index
    end
  end

  describe 'current_user' do
    it 'if valid credentials, it will create current_user' do
      response_double = double(code: 200, body: "{\"id\":17,\"username\":\"blah\",\"email\":\"blah@blah.com\",\"password_hash\":\"password\",\"zipcode\":null,\"logged_in\":true,\"admin\":false,\"wags\":7,\"created_at\":\"2015-05-31T17:56:46.073Z\",\"updated_at\":\"2015-05-31T18:52:36.266Z\"}")
      allow(HTTParty).to receive(:get).and_return(response_double)
      get :index, {email: "blah@blah.com", password_hash: "password"}
      expect(assigns(:current_user)["id"]).to eq 17
    end

    context "no user" do
      before(:each) do
        response_double = double(code: 401, body: "{\"logged_in\":false}")
        allow(HTTParty).to receive(:get).and_return(response_double)
      end

      it 'does not create current_user if user is logged out' do
        get :index, {email: "blah@blah.com", password_hash: "password"}
        expect(assigns(:current_user)).to be_nil
      end

      it "responds with 'invalid credentials' if user is logged out" do
        get :index, {email: "blah@blah.com", password_hash: "password"}
        expect(response.body).to eq ("invalid credentials")
      end

      it "responds with 'invalid credentials' if you don't give any credentials" do
        get :index
        expect(response.body).to eq ("invalid credentials")
      end
    end
  end

end
