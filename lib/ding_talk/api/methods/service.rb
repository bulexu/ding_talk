module DingTalk
  module Api
    module Methods
      module Service

        # todo
        def get_corp_token auth_corpid, permanent_code
          post 'service/get_corp_token', {suite_id: suite_key, auth_corpid: auth_corpid, permanent_code: permanent_code}
        end

      end
    end
  end
end