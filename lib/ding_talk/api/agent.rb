module DingTalk
  module Api
    class Agent < Base

      attr_reader :agent_id, :app_key, :app_secret

      def initialize(options={})
        @agent_id = options.delete(:agent_id)
        @agent_id = @agent_id.to_i if @agent_id.to_s =~ /\A\d+\Z/
        @app_key = options.delete(:app_key)
        @app_secret = options.delete(:app_secret)
        super(options)
      end

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

      def access_token
        token_store.token
      end

      private
      def signature_params
        timestamp = timestamp_q.to_s
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
