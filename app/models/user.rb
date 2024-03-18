class User < ApplicationRecord
  has_secure_password

  validates :name, presence: :true, length: { maximum: 50 }
  validates :email, presence: :true, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email, with: -> name { name.strip }
  normalizes :email, with: -> email { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  # Can also do this for email confirmations, like this:
  # generates_token_for :email_confirmation, expires_in: 24.hours does
  #   email
  # end
end
