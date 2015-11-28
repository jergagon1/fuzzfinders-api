require 'rails_helper'

RSpec.describe Report, type: :model do
  it { should validate_presence_of :user_id }
  it { should have_many :comments }
  it { should have_many :subscriptions }
  it { should belong_to :user }

  describe 'Subscriptions logic' do
    context 'User creates report' do
      before { @report = create :report }

      it 'subscriptions count should be one' do
        expect(@report.subscriptions.count).to eq(1)
      end

      it 'subscription\'s user should equals report\'s user' do
        expect(@report.subscriptions.first.user).to eq(@report.user)
      end
    end
  end
end
