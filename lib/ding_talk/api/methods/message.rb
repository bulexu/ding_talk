require "erb"

module DingTalk
  module Api
    module Methods
      module Message
        def text_message_send user_ids, department_ids, content
          message_send user_ids, department_ids, { text: { content: content }, msgtype: 'text' }
        end

        def image_message_send user_ids, department_ids, media_id
          message_send user_ids, department_ids, { image: { media_id: media_id }, msgtype: 'image' }
        end

        def voice_message_send user_ids, department_ids, media_id, duration
          message_send user_ids, department_ids, { voice: { media_id: media_id, duration: duration }, msgtype: 'voice' }
        end

        def file_message_send user_ids, department_ids, media_id
          message_send user_ids, department_ids, { file: { media_id: media_id }, msgtype: 'file' }
        end

        def link_message_send user_ids, department_ids, link = {}
          message_send user_ids, department_ids, { link: link, msgtype: 'link' }
        end

        def oa_message_send user_ids, department_ids, oa = {}
          message_send user_ids, department_ids, { oa: oa, msgtype: 'oa' }
        end

        def markdown_message_send user_ids, department_ids, markdown = {}
          message_send user_ids, department_ids, { markdown: markdown, msgtype: 'markdown' }
        end

        def textcard_message_send user_ids, department_ids, textcard = {}
          message_send user_ids, department_ids, { textcard: textcard, msgtype: 'textcard' }
        end

        def action_card_message_send user_ids, department_ids, action_card = {}
          message_send user_ids, department_ids, { action_card: action_card, msgtype: 'action_card' }
        end

        private
        # https://developers.dingtalk.com/document/app/asynchronous-sending-of-enterprise-session-messages/h2-kms-9i7-ynw
        def message_send user_ids, department_ids, payload = {}
          # userid_list, dept_id_list = Array.wrap(user_ids), Array.wrap(department_ids)
          # batch_count = [(userid_list.size / 100.0).ceil, (dept_id_list.size / 20.0).ceil].max
          # batch_count.times do |time|
          #   users = userid_list[time, (time+1)*100]
          #   departments = department_ids[time, (time+1)*20]
          #   payload[:agentid] = agent_id
          #   payload[:userid_list] = users.join(',') if users.present?
          #   payload[:dept_id_list] = departments.join(',') if departments.present?
          #
          #   post 'topapi/message/corpconversation/asyncsend_v2', payload
          # end

          msg = payload.dup
          payload[:msg] = msg
          payload[:agent_id] = agent_id
          payload[:userid_list] = Array.wrap(user_ids).join(',') if user_ids.present?
          payload[:dept_id_list] = Array.wrap(department_ids).join(',') if department_ids.present?

          post 'topapi/message/corpconversation/asyncsend_v2', payload
        end
      end
    end
  end
end
