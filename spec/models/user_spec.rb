# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :email }
    it { should have_secure_password }

    it 'is invalid with a password shorter than 8 characters' do
      inv_pw = Faker::Internet.password(min_length: 6, max_length: 7)
      user = build(:user, password: inv_pw, password_confirmation: inv_pw)
      error_message = 'is too short (minimum is 8 characters)'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include(error_message)
    end
  end
end
