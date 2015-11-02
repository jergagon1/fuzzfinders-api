require 'rails_helper.rb'

RSpec.describe ReportsController, type: :controller do

  describe 'create' do

    xit 'it will post a report' do

      expect {post :create, {
        email: "blah@blah.com",
        password_hash: "password",
        report: {pet_name: "rebecca", animal_type: 'micropig'}
      }}.to change(Report, :count).by(1)
    end

  end

end
