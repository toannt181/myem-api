require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  validates :email, presence: true

  has_many :oauths

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def is_authenticated?(verified_password)
    password == verified_password
  end
end
