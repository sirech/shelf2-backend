class User < ActiveRecord::Base
  attr_accessor :password
  validates :name, presence: true, uniqueness: true, length: { in: 6..20 }
  validates_length_of :password, in: 8..64, on: :create

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    self.checksum = BCrypt::Password.create(password)
  end

  def clear_password
    self.password = nil
  end

  def auth?(pwd)
    BCrypt::Password.new(checksum) == pwd
  end
end
