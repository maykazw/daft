require 'rails_helper'

RSpec.describe User, type: :model do
  context 'create ok' do
    subject { create(:user) }
    it { is_expected.to be_valid }
  end

  context 'send email' do
    let(:user) {create(:user)  }
    it "sends an email" do
      expect { user.send_registration_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'validation test' do
    it 'name presence' do
      user = User.new(email: 'sample@example.com').save
      expect(user).to eq(false)
    end
    it 'email presence' do
      user = User.new(email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    it 'date of birth error' do
      user = User.new(name: "test", date_of_birth: "qwerttyuiop", email: 'sample@example.com').save
      expect(user).to eq(false)
    end

  end


end