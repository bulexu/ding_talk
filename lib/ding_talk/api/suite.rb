require 'builder'

module DingTalk
  module Api
    class Suite < Base

      include DingTalk::Cipher

      attr_reader :encoding_aes_key, :suite_key, :suite_secret, :suite_token, :token

      def initialize(options={})
        @suite_key = options.delete(:suite_key)
        @suite_secret = options.delete(:suite_secret)
        @token = @suite_token = options.delete(:suite_token)
        @encoding_aes_key = options.delete(:encoding_aes_key)
        super(options)
      end

      def suite_ticket= ticket
        DingTalk.redis.set ticket_key, ticket
      end

      def suite_ticket
        DingTalk.redis.get ticket_key
      end

      private

      def token_params
        {suite_access_token: access_token}
      end

      def ticket_key
        "SUITE_TICKET_#{suite_key}"
      end

      def token_store
        @token_store ||= Token::SuiteToken.new self
      end

    end
  end
end