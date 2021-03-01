require 'jwt'
require 'net/http'

class JsonWebToken
  class << self
    def verify(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: 'RS256',
                 iss: 'https://hceris.eu.auth0.com/',
                 verify_iss: true,
                 aud: 'shelf2.hceris.com',
                 verify_aud: true) do |header|
        jwks_hash[header['kid']]
      end
    end

    def jwks_hash
      jwks_raw = Net::HTTP.get URI('https://hceris.eu.auth0.com/.well-known/jwks.json')
      jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
      jwks_keys.map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(Base64.decode64(k['x5c'].first)).public_key
        ]
      end.to_h
    end
  end
end
