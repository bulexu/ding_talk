require 'ding_talk/token/base'

module DingTalk
  module Token
    class SuiteToken < Base

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "DING_SUITE_TOKEN_#{client.suite_key}_#{client.suite_secret}_#{client.suite_token}"
      end

      def token_key
        'suite_access_token'
      end

      def refresh_token
        client.request.post 'service/get_suite_token', {suite_key: client.suite_key, suite_secret: client.suite_secret, suite_ticket: client.suite_ticket}
      end

    end
  end
end