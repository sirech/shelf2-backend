require 'json_web_token'

class AuthenticateUser
  prepend SimpleCommand

  def initialize(name, password)
    @name = name
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :name, :password

  def user
    user = User.find_by_name(name)
    return user if user&.auth?(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
