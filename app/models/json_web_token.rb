class JsonWebToken

  KEY = ENV['DEVISE_JWT_SECRET_KEY']

  def self.encode(payload)
    expiration = 2.weeks.from_now.to_i
    JWT.encode payload.merge(exp: expiration), KEY
  end

  def self.decode(token)
    JWT.decode(token, KEY).first
  end
end
