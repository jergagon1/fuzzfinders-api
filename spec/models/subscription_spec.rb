require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :report_id }
end
