class User < ApplicationRecord
    has_secure_password
    validates :name, length: { minimum: 3 }, presence: true
    validates :surname, length: { minimum: 3 }, presence: true
    validates :description, presence: true, length: { minimum: 50 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :phone, presence: true, numericality: { only_integer: true }
    validates :birthday, presence: true
end
