require 'json'

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(payload, exp = 24.hours.from_now)
      data = { data: payload, exp: exp }
      token = JWT.encode(payload, SECRET_KEY)
      return { access_token: token, exp: exp }
    end

    def decode(payload)
      JWT.decode(payload, SECRET_KEY)
    end
  end
end