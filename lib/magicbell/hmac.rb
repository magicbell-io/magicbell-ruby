require "openssl"
require "base64"

module MagicBell
  module HMAC
    class << self
      def calculate(message)
        secret = MagicBell.api_secret
        digest = OpenSSL::Digest::Digest.new('sha256')
        Base64.encode64(OpenSSL::HMAC.digest(digest, secret, message)).strip
      end
    end
  end
end
