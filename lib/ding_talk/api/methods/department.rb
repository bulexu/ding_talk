module DingTalk
  module Api
    module Methods
      module Department
        # https://developers.dingtalk.com/document/app/create-a-department-v2
        def department_create data={}
          post 'topapi/v2/department/create', data
        end

        def department_update department_id, data={}
          post 'topapi/v2/department/update', data.merge(dept_id: department_id)
        end

        def department_delete department_id
          post 'topapi/v2/department/delete', {dept_id: department_id}
        end

        def department_get department_id
          post 'topapi/v2/department/get', {dept_id: department_id}
        end

        # parent_id 父部门ID。 如果不传，默认部门为根部门，根部门ID为1。
        # fetch_child 是否递归部门的全部子部门
        def departments parent_id=1, fetch_child=false
          get 'department/list', {
            access_token: access_token,
            id: parent_id,
            fetch_child: fetch_child
          }
        end

        # https://developers.dingtalk.com/document/app/obtain-the-department-list-v2
        def department_children department_id=nil
          if department_id.nil?
            post 'topapi/v2/department/listsub'
          else
            post 'topapi/v2/department/listsub', {dept_id: department_id}
          end
        end

        # https://developers.dingtalk.com/document/app/obtain-the-department-list-v2
        def ancestor_ids department_id
          post 'topapi/v2/department/listparentbydept', {dept_id: department_id}
        end
      end
    end
  end
end