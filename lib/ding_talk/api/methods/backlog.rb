module DingTalk
  module Api
    module Methods
      module Backlog
        def backlog_create(unionid, data)
          open_post "v1.0/todo/users/#{unionid}/tasks?operatorId=#{unionid}", data.merge({ creatorId: unionid }), {'x-acs-dingtalk-access-token': access_token}
        end

        def backlog_get(unionid, taskid)
          open_get "v1.0/todo/users/#{unionid}/tasks/#{taskid}", {'x-acs-dingtalk-access-token': access_token}
        end

        def backlog_update(unionid, taskid, data)
          open_put "v1.0/todo/users/#{unionid}/tasks/#{taskid}?operatorId=#{unionid}", data, {'x-acs-dingtalk-access-token': access_token}
        end

        def backlog_delete(unionid, taskid)
          open_delete "v1.0/todo/users/#{unionid}/tasks/#{taskid}?operatorId=#{unionid}", {'x-acs-dingtalk-access-token': access_token}
        end

      end
    end
  end
end