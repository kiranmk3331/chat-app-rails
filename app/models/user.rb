class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 3, maximum: 20 }, uniqueness: true
  has_many :messages
  has_secure_password
end
