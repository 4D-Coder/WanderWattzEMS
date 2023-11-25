# frozen_string_literal: true

# Description/Explanation of User class
class User < ApplicationRecord
  validates :first_name, :last_name, :phone_number, :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password_digest.nil? }
  has_secure_password
end
