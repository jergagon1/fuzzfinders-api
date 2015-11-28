require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :report_id }
  it { should validate_presence_of :content }

  it { should belong_to :report }
  it { should belong_to :user }

  describe 'Subscriptions logic' do
    context 'User should be subscribed only once' do
      it 'for many comments' do
        @report1 = create :report

        expect(@report1.user.subscriptions.count).to eq 1

        @comment1 = create :comment, report: @report1

        expect(Subscription.pluck(:user_id)).to match_array([@report1.user_id, @comment1.user_id])

        @comment2 = create :comment, report: @report1

        expect(Subscription.pluck(:user_id)).to match_array([@report1, @comment1, @comment2].map &:user_id)

        @comment3 = create :comment, report: @report1, user: @report1.user

        expect(Subscription.pluck(:user_id)).to match_array([@report1, @comment1, @comment2].map &:user_id)
      end
    end


    context 'User creates comment' do
      before { @comment = create :comment }

      it 'subscriptions count should be two (one for report and one for comment)' do
        expect(@comment.report.subscriptions.count).to eq(2)
      end

      it 'subscription\'s user should equals report\'s user' do
        expect(@comment.report.subscriptions.map(&:user)).to include(@comment.user)
      end
    end
  end
end

