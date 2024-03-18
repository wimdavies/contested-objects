class User < ApplicationRecord
  has_secure_password

  validates :name, presence: :true, length: { maximum: 50 }
  validates :email, presence: :true, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email, with: -> name { name.strip }
  normalizes :email, with: -> email { email.strip.downcase }
end
