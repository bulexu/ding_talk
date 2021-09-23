module DingTalk
  module Api
    class Corp < Base

      include DingTalk::Cipher

      attr_reader :suite, :permanent_code

      def initialize(options={})
        @suite = options.delete(:suite)
        @permanent_code = options.delete(:permanent_code)
        super(options)
      end

      def agent(agent_id)
        Wework::Api::Agent.new(corp_id: corp_id, agent_id: agent_id, token_store: token_store)
      end

      private

      def token_store
        @token_store ||= Token::CorpToken.new self
      end

    end
  end
end