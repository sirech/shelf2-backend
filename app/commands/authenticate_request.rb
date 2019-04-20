require 'json_web_token'

class AuthenticateRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    verify
  end

  private

  attr_reader :headers

  def verify
    payload, = ::JsonWebToken.verify(token)
    scopes(payload).include?('create:books').tap do |has_scope|
      errors.add(:token, 'Missing scope') unless has_scope
    end
  rescue JWT::DecodeError => e
    errors.add(:token, 'Cannot decode JWT', e)
    false
  end

  def scopes(payload)
    payload['scope'].split(' ')
  end

  def token
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    errors.add :token, 'Missing token'
    nil
  end
end
