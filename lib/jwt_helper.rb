# frozen_string_literal: true

module JWTHelper # :nodoc:
  def encode(payload)
    JWT.encode(payload, jwt_secret)
  end

  def decode(jwt_token)
    JWT.decode(jwt_token, jwt_secret)[0]
  end

  def get(jwt_token, key)
    decode(jwt_token).try(:[], key)
  end

  def jwt_secret
    ENV['RAILS_MASTER_KEY']
  end

  module_function :encode, :decode, :jwt_secret, :get
end
