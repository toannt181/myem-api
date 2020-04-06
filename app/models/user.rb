require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  validates :email, :password, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def is_authenticated?(verified_password)
    password == verified_password
  end
end
