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

  describe 'Slug' do
    subject { @report.slug }

    context 'when every field filled' do
      before do
        @report = create :report, id: 42, pet_name: 'Sheldon', animal_type: 'Dog', report_type: 'Lost'
      end

      it { expect(subject).to eql '42-lost-dog-sheldon' }
    end

    context 'when only report type filled' do
      before { @report = create :report, id: 42, report_type: 'Found', pet_name: '', animal_type: '' }

      it { expect(subject).to eql '42-found' }
    end

    context 'when strange characters' do
      before do
        @report = create :report, id: 42,
          report_type: 'Found', pet_name: '--<>+_(_?*)--',
          animal_type: '(0&^%!@$__>/?\')'
      end

      it { expect(subject).to eql '42-found' }
    end

    context 'changes after update' do
      before do
        @report = create :report, id: 42, pet_name: 'Spiky', animal_type: 'Dog', report_type: 'Lost'
      end

      it { expect(subject).to eql '42-lost-dog-spiky' }

      context 'update' do
        before do
          @report.update(pet_name: 'Spiky Junior', animal_type: 'Puppy', report_type: 'lost')
        end

        it { expect(subject).to eql '42-lost-puppy-spiky-junior' }
      end
    end
  end
end
