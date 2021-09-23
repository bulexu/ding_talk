require "erb"

module DingTalk
  module Api
    module Methods
      module Chat

        def chat_create name, owner, users
          post 'chat/create',
               name: name,
               owner: owner,
               useridlist: users
        end

        def chat_update chat_id, payload = {}
          payload.merge! chatid: chat_id
          post 'chat/update', payload
        end

        # def chat_get chat_id
        #   get 'chat/get', { params: { chatid: chat_id } }
        # end

        def text_chat_send chat_id, content
          chat_send chat_id, { text: { content: content }, msgtype: 'text' }
        end

        def image_chat_send chat_id, media_id
          chat_send chat_id, { image: { media_id: media_id }, msgtype: 'image' }
        end

        # duration 正整数，小于60，表示音频时长
        def voice_chat_send chat_id, media_id, duration
          chat_send chat_id, { voice: { media_id: media_id, duration: duration }, msgtype: 'voice' }
        end

        def file_chat_send chat_id, media_id
          chat_send chat_id, { file: { media_id: media_id }, msgtype: 'file' }
        end

        def link_chat_send chat_id, link = {}
          chat_send chat_id, { link: link, msgtype: 'link' }
        end

        def oa_chat_send chat_id, oa = {}
          chat_send chat_id, { oa: oa, msgtype: 'oa' }
        end

        def markdown_chat_send chat_id, markdown = {}
          chat_send chat_id, { markdown: markdown, msgtype: 'markdown' }
        end

        def textcard_chat_send chat_id, textcard = {}
          chat_send chat_id, { textcard: textcard, msgtype: 'textcard' }
        end

        def action_card_chat_send chat_id, action_card = {}
          chat_send chat_id, { action_card: action_card, msgtype: 'action_card' }
        end

        private

        def chat_send chat_id, payload = {}
          payload.merge!(chatid: chat_id)
          post 'chat/send', payload
        end
      end
    end
  end
end
