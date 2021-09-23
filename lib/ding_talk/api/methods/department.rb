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