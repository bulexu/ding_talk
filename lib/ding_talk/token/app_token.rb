require 'ding_talk/token/base'

module DingTalk
  module Token
    class AppToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "DING_APP_TOKEN_#{client.corp_id}"
      end

      def token_key
        'access_token'
      end

      def signature(timestamp)
        sign = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), client.app_secret, timestamp)
        CGI.escape(Base64.encode64(sign).gsub(/\n/, ''))
      end

      def refresh_token
        client.request.get 'gettoken', params: {corpid: client.app_key, corpsecret: client.app_secret}
      end

    end
  end
end