require 'google/apis/oauth2_v2'

class AuthenticateRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    valid_user?
  end

  private

  attr_reader :headers

  def valid_user?
    %w[sirech].include?(email).tap do |is_valid|
      errors.add(:token, 'Invalid user') unless is_valid
    end
  end

  def email
    email = token_info&.email
    email ? email.split('@').first : nil
  end

  def token_info
    return @token_info if defined?(@token_info)

    @token_info = begin
                    oauth2.tokeninfo(access_token: token)
                  rescue Google::Apis::ClientError
                    errors.add(:token, 'Could not verify identity')
                    nil
                  end
  end

  def oauth2
    Google::Apis::Oauth2V2::Oauth2Service.new
  end

  def token
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    errors.add :token, 'Missing token'
    nil
  end
end
