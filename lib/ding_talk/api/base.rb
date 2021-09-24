require 'ding_talk/request'

module DingTalk
  module Api
    class Base

      include Methods::Media
      include Methods::User
      include Methods::Department
      include Methods::Message
      include Methods::Chat
      include Methods::Backlog

      attr_accessor :corp_id, :options

      def initialize options = {}
        @corp_id = options.delete(:corp_id)
        @token_store = options.delete(:token_store)
        @options = options
      end

      def request
        @request ||= DingTalk::Request.new(AUTHORIZE_ENDPOINT, false)
      end

      def open_request
        @open_request ||= DingTalk::Request.new(AUTHORIZE_ENDPOINT_OPEN, false)
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

      def open_get(path, headers = {})
        open_request.get path, headers
      end

      def open_post(path, payload={}, headers = {})
        open_request.post path, payload, headers
      end

      def open_put(path, payload={}, headers = {})
        open_request.put path, payload, headers
      end

      def open_delete(path, headers = {})
        open_request.delete path, headers
      end

      def nonce
        SecureRandom.hex(8)
      end

      def timestamp
        Time.now.to_i.to_s
      end

      def timestamp_q
        (Time.now.to_i * 1000).to_s
      end

    end
  end
end