RSpec.describe DingTalk do

  before do
    @agent = DingTalk::Api::Agent.new(
      corp_id: ENV['CORP_ID'],
      agent_id: ENV['AGENT_ID'],
      app_key: ENV['APP_KEY'],
      app_secret: ENV['APP_SECRET']
    )
    @userid = 'manager2922'
    @image_id = '@lADPDe7s1DooS4nNBVXNCAA'
    @video_id = '@lAbPDe7s1Do8azHOdBgg4s5fwKMM'
    @voice_id = '@lAXPDf0izs1NbB3Obyx7m85DN3LY'
    @file_id = '@lA7PDgCwTXIVlcPOLc-Jtc5PeZVL'
  end

  describe 'init' do
    it "test_valid?" do
      expect(@agent.valid?).to eq(true)
    end
  end

  describe 'Api::Methods::User' do
    userid = ''
    unionid = ''
    department_ids = []
    userinfo = {}
    it 'user_get_userid_by_mobile' do
      response = @agent.user_get_userid_by_mobile '17660643271'
      userid = response.result['userid']
      expect(response.errcode).to eq 0
      expect(userid.present?).to eq true
    end

    it 'user_get' do
      response = @agent.user_get userid
      userinfo = response.result
      unionid = userinfo['unionid']
      department_ids = userinfo['dept_id_list']
      expect(response.errcode).to eq 0
      expect(userinfo.present?).to eq true
    end

    it 'user_get_userid_by_unionid' do
      response = @agent.user_get_userid_by_unionid unionid
      userid = response.result['userid']
      expect(response.errcode).to eq 0
      expect(userid.present?).to eq true
    end

    it 'user_simplelist' do
      expect(department_ids.present?).to eq true
      response = @agent.user_simplelist department_ids.first
      members = response.result['list']
      expect(response.errcode).to eq 0
      expect(members.present?).to eq true
      expect(members.any?{|member| member['userid'] == userid}).to eq true
    end

    it 'user_list' do
      expect(department_ids.present?).to eq true
      response = @agent.user_list department_ids.first
      members = response.result['list']
      expect(response.errcode).to eq 0
      expect(members.present?).to eq true
      expect(members.any?{|member| member['userid'] == userid}).to eq true
    end

    # https://open-dev.dingtalk.com/apiExplorer?spm=ding_open_doc.document.0.0.1ef74981xEcnf9#/jsapi?api=runtime.permission.requestAuthCode
    it 'user_get_userinfo_by_sns' do
      code = 'f939cf4de2d830789d2cf7f63d69499b'
      response = @agent.user_get_userinfo_by_sns code
      userinfo = response.result
      expect(response.errcode).to eq 0
      expect(userinfo.present?).to eq true
    end

    # done
    it 'user_get_userid_by_code' do
      code = 'f503c6d2f047393e9c0eb8f8d8400874'
      response = @agent.user_get_userinfo_by_code code
      userinfo = response.result
      expect(response.errcode).to eq 0
      expect(userinfo.present?).to eq true
    end
  end

  describe 'Api::Methods::Department' do
    department_id = ''
    it 'department_create' do
      data = {
        name: 'test_dept',
        parent_id: 1
      }
      response = @agent.department_create data
      department_id = response.result['dept_id']
      expect(response.errcode).to eq 0
      expect(department_id.present?).to eq true
    end

    it 'department_update' do
      data = {
        name: 'test_dept_aaa',
        parent_id: 1
      }
      response = @agent.department_update department_id, data
      expect(response.errcode).to eq 0
    end

    it 'department_children' do
      response = @agent.department_children
      departments = response.result
      expect(response.errcode).to eq 0
      expect(departments.present?).to eq true

      response = @agent.department_children department_id
      departments = response.result
      expect(response.errcode).to eq 0
      expect(departments.blank?).to eq true
    end

    it 'ancestor_ids' do
      response = @agent.ancestor_ids department_id
      ancestor_ids = response.result['parent_id_list']
      expect(response.errcode).to eq 0
      expect(ancestor_ids).to eq [department_id.to_i, 1]
    end

    it 'department_get' do
      response = @agent.department_get department_id
      department = response.result
      expect(response.errcode).to eq 0
      expect(department.present?).to eq true
    end

    it 'department_delete' do
      response = @agent.department_delete department_id
      expect(response.errcode).to eq 0
    end

  end

  describe 'Api::Methods::Media' do
    it 'image' do
      image_path = File.join(File.dirname(__FILE__), '../files/wallhaven-396jky.jpg')
      response = @agent.media_upload('image', image_path)
      expect(response.errcode).to eq 0
      expect(response.media_id.present?).to eq true
    end

    it 'video' do
      video_path = File.join(File.dirname(__FILE__), '../files/1578886383568864.mp4')
      response = @agent.media_upload('video', video_path)
      expect(response.errcode).to eq 0
      expect(response.media_id.present?).to eq true
    end

    it 'voice' do
      voice_path = File.join(File.dirname(__FILE__), '../files/music.mp3')
      response = @agent.media_upload('voice', voice_path)
      expect(response.errcode).to eq 0
      expect(response.media_id.present?).to eq true
    end

    it 'file' do
      file_path = File.join(File.dirname(__FILE__), '../files/test.pptx')
      response = @agent.media_upload('file', file_path)
      expect(response.errcode).to eq 0
      expect(response.media_id.present?).to eq true
    end

  end

  describe 'Api::Methods::Chat' do
    userids = ['284317422039332945', '012350431229173120', '1225573624847741', '64211544511086442']
    chatid = 'chat927105d13cc07f6aaca6827dd92bc2b2'
    # it 'chat_create' do
    #   response = @agent.chat_create '测试建群', @userid, userids
    #   expect(response.errcode).to eq 0
    #   chatid = response['chatid']
    #   expect(chatid.present?).to eq true
    # end

    it 'chat_update' do
      response = @agent.chat_update chatid, { name: '测试建群aaa' }
      expect(response.errcode).to eq 0
    end

    # it 'chat_get' do
    #   response = @agent.chat_get chatid
    #   expect(response.errcode).to eq 0
    #   expect(response.chat_info['name']).to eq '测试建群aaa'
    # end

    it 'text_chat_send' do
      response = @agent.text_chat_send chatid, '测试文本消息'
      expect(response.errcode).to eq 0
    end

    it 'image_chat_send' do
      response = @agent.image_chat_send chatid, @image_id
      expect(response.errcode).to eq 0
    end

    it 'voice_chat_send' do
      response = @agent.voice_chat_send chatid, @voice_id, 15
      expect(response.errcode).to eq 0
    end

    it 'file_chat_send' do
      response = @agent.file_chat_send chatid, @file_id
      expect(response.errcode).to eq 0
    end

    it 'link_chat_send' do
      payload = {
        message_url: "https://www.wikiworks.cn",
        pic_url: @image_id,
        title: "测试",
        text: "测试"
      }
      response = @agent.link_chat_send chatid, payload
      expect(response.errcode).to eq 0
    end

    it 'oa_chat_send' do
      payload = {
        message_url: "http://www.wikiworks.cn",
        head: {
          bgcolor: "FFBBBBBB",
          text: "头部标题"
        },
        body: {
          title: "正文标题",
          form: [
            {
              key: "姓名:",
              value: "张三"
            },
            {
              key: "年龄:",
              value: "20"
            },
            {
              key: "身高:",
              value: "1.8米"
            },
            {
              key: "体重:",
              value: "130斤"
            },
            {
              key: "学历:",
              value: "本科"
            },
            {
              key: "爱好:",
              value: "打球、听音乐"
            }
          ],
          rich: {
            num: "15.6",
            unit: "元"
          },
          content: "大段文本大段文本大段文本大段文本大段文本大段文本",
          image: @image_id,
          file_count: "3",
          author: "李四 "
        }
      }
      response = @agent.oa_chat_send chatid, payload
      expect(response.errcode).to eq 0
    end

    it 'markdown_chat_send' do
      payload = {
        title: "首屏会话透出的展示内容",
        text: "# 这是支持markdown的文本   \n   ## 标题2    \n   * 列表1   \n  ![alt 啊](https://img.alicdn.com/tps/TB1XLjqNVXXXXc4XVXXXXXXXXXX-170-64.png)"
      }
      response = @agent.markdown_chat_send chatid, payload
      expect(response.errcode).to eq 0
    end

    it 'action_card_chat_send' do
      payload = {
        title: "是透出到会话列表和通知的文案",
        markdown: "支持markdown格式的正文内容",
        single_title: "查看详情",
        single_url: "https://www.wikiworks.cn"
      }
      response = @agent.action_card_chat_send chatid, payload
      expect(response.errcode).to eq 0
    end

  end

  describe 'Api::Methods::Chat' do
    userids = ['284317422039332945', 'manager2922']
    department_ids = [1]
    it 'text_message_send' do
      response = @agent.text_message_send userids, department_ids, '测试文本消息'
      expect(response.errcode).to eq 0
    end

    it 'image_message_send' do
      response = @agent.image_message_send userids, department_ids, @image_id
      expect(response.errcode).to eq 0
    end

    it 'voice_message_send' do
      response = @agent.voice_message_send userids, department_ids, @voice_id, 15
      expect(response.errcode).to eq 0
    end

    it 'file_message_send' do
      response = @agent.file_message_send userids, department_ids, @file_id
      expect(response.errcode).to eq 0
    end

    it 'link_message_send' do
      payload = {
        messageUrl: "https://www.wikiworks.cn",
        picUrl: @image_id,
        title: "测试",
        text: "测试"
      }
      response = @agent.link_message_send userids, department_ids, payload
      expect(response.errcode).to eq 0
    end

    it 'oa_message_send' do
      payload = {
        message_url: "http://www.wikiworks.cn",
        head: {
          bgcolor: "FFBBBBBB",
          text: "头部标题"
        },
        body: {
          title: "正文标题",
          form: [
            {
              key: "姓名:",
              value: "张三"
            },
            {
              key: "年龄:",
              value: "20"
            },
            {
              key: "身高:",
              value: "1.8米"
            },
            {
              key: "体重:",
              value: "130斤"
            },
            {
              key: "学历:",
              value: "本科"
            },
            {
              key: "爱好:",
              value: "打球、听音乐"
            }
          ],
          rich: {
            num: "15.6",
            unit: "元"
          },
          content: "大段文本大段文本大段文本大段文本大段文本大段文本",
          image: @image_id,
          file_count: "3",
          author: "李四 "
        }
      }
      response = @agent.oa_message_send userids, department_ids, payload
      expect(response.errcode).to eq 0
    end

    it 'markdown_message_send' do
      payload = {
        title: "首屏会话透出的展示内容",
        text: "# 这是支持markdown的文本   \n   ## 标题2    \n   * 列表1   \n  ![alt 啊](https://img.alicdn.com/tps/TB1XLjqNVXXXXc4XVXXXXXXXXXX-170-64.png)"
      }
      response = @agent.markdown_message_send userids, department_ids, payload
      expect(response.errcode).to eq 0
    end

    it 'action_card_message_send' do
      payload = {
        title: "是透出到会话列表和通知的文案",
        markdown: "支持markdown格式的正文内容",
        single_title: "查看详情",
        single_url: "https://www.wikiworks.cn"
      }
      response = @agent.action_card_message_send userids, department_ids, payload
      expect(response.errcode).to eq 0
    end
  end

end
