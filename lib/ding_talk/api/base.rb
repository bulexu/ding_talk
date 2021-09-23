require 'ding_talk/request'

module DingTalk
  module Api
    class Base

      include Methods::Media
      include Methods::User
      include Methods::Department

      attr_accessor :corp_id, :options

      def initialize options = {}
        @corp_id = options.delete(:corp_id)
        @token_store = options.delete(:token_store)
        @options = options
      end

      def request
        @request ||= DingTalk::Request.new(AUTHORIZE_ENDPOINT, false)
      end

      def valid?
        return false if corp_id.nil?
        token_store.token.present?
      rescue AccessTokenExpiredError
        false
      rescue => e
        Rails.logger.error "[DingTalk] (valid?) fetch access token error(#{corp_id}): #{e.inspect}" if defined?(Rails)
        false
      end

      def get(path, headers = {})
        with_token(headers[:params]) do |params|
          request.get path, headers.merge(params: params)
        end
      end

      def post(path, payload={}, headers = {})
        with_token(headers[:params]) do |params|
          request.post path, payload, headers.merge(params: params)
        end
      end

      def post_with_signature(path, payload, headers = {})
        with_signature(headers[:params]) do |params|
          request.post path, payload, headers.merge(params: params)
        end
      end

      def post_file(path, file, headers = {})
        with_token(headers[:params]) do |params|
          request.post_file path, file, headers.merge(params: params)
        end
      end

      def access_token
        token_store.token
      end

      private

      def with_token(params = {}, tries = 2)
        params ||= {}
        yield(params.merge(token_params))
      rescue AccessTokenExpiredError
        token_store.update_token
        retry unless (tries -= 1).zero?
      end

      def with_signature(params = {})
        params ||= {}
        yield(params.merge(signature_params))
      end

      def token_store
        @token_store ||= Token::AppToken.new self
      end

      def token_params
        { access_token: access_token }
      end

      def signature_params
        timestamp = token_store.timestamp_q.to_s
        hash = {
          accessKey: app_key,
          timestamp: timestamp,
          signature: token_store.signature(timestamp)
        }
        puts hash
        hash
      end

    end
  end
end