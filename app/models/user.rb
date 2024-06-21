# frozen_string_literal: true

# The User model represents a user in the system. It includes validations for user attributes
# and enforces password complexity requirements. This model uses the `has_secure_password`
# method provided by Rails, which requires the bcrypt gem, to securely hash and store passwords.
#
# Attributes:
# - name: [String] The name of the user. It must be present.
# - password: [String] The user's password. It must be present, have a length between 10 to 16 characters,
#   include at least one lowercase letter, one uppercase letter, and one digit. It also must not have
#   three consecutive repeating characters.
class User < ApplicationRecord
  has_secure_password

  ONE_LOWER_ONE_UPPER_ONE_DIGIT_REGEX = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/

  validates :name, presence: true
  validates :password, presence: true, length: { in: 10..16 }, format: { with: ONE_LOWER_ONE_UPPER_ONE_DIGIT_REGEX,
                                                                         message: :invalid_password_format },
                       unless: lambda {
                                 password.blank?
                               }
  validate :no_consecutive_repeating_characters

  private

  def no_consecutive_repeating_characters
    return if password.blank?

    return unless password.match(/(.)\1\1/)

    errors.add(:password, :consecutive_repeating_characters)
  end
end
