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

      def post(path, payload={}, headers = {})
        with_token(headers[:params]) do |params|
          request.post path, payload, headers.merge(params: params)
        end
      end


    end
  end
end
