module DingTalk
  module Api
    module Methods
      module User
        # todo test
        def user_get_userinfo_by_sns code
          post_with_signature 'sns/getuserinfo_bycode', { tmp_auth_code: code }
        end

        def user_get_userinfo_by_code code
          post 'topapi/v2/user/getuserinfo', { code: code }
        end

        def user_get_userid_by_mobile mobile
          post 'topapi/v2/user/getbymobile', { mobile: mobile }
        end

        def user_get_userid_by_unionid unionid
          post 'topapi/user/getbyunionid', { unionid: unionid }
        end

        # todo test
        # def user_update userid, data = {}
        #   post 'topapi/v2/user/update', data.merge(userid: userid)
        # end

        # todo test
        # def user_create data = {}
        #   post 'topapi/v2/user/create', data
        # end

        def user_get userid
          post 'topapi/v2/user/get', { userid: userid }
        end

        # todo test
        # def user_delete userid
        #   post 'topapi/v2/user/delete', { userid: userid }
        # end

        # https://developers.dingtalk.com/document/app/queries-the-simple-information-of-a-department-user
        def user_simplelist department_id, cursor: 0, size: 10, order_field: 'entry_asc'
          post 'topapi/user/listsimple', {
            dept_id: department_id,
            cursor: cursor,
            size: size,
            order_field: order_field
          }
        end

        def user_list department_id, cursor: 0, size: 10, order_field: 'entry_asc'
          post 'topapi/v2/user/list', {
            dept_id: department_id,
            cursor: cursor,
            size: size,
            order_field: order_field
          }
        end

        def userid_list department_id
          post 'topapi/user/listid', {dept_id: department_id}
        end

      end
    end
  end
end