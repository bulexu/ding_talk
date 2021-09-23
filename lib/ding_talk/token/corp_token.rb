require 'ding_talk/token/base'

module DingTalk
  module Token
    class CorpToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "DING_CORP_TOKEN_#{client.corp_id}_#{client.permanent_code}"
      end

      def token_key
        'access_token'
      end

      def signature(timestamp)
        signature = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), client.suite_secret, timestamp + '\n' + client.suite_ticket)
        CGI.escape(Base64.encode64(signature).gsub(/\n/, ''))
      end

      def refresh_token
        client.suite.get_corp_token(client.corp_id, client.permanent_code)
      end
    end
  end
end