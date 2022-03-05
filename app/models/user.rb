
class User < ApplicationRecord
  include BCrypt 

  has_secure_password 
  validates_uniqueness_of :dni 
  validates_presence_of :name, :last_name, :dni, :password_digest

  has_many :accounts
end
