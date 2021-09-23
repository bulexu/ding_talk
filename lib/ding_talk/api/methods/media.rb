module DingTalk
  module Api
    module Methods
      module Media
        # public API
        def media_upload(type, file)
          post_file 'media/upload', file, params: { type: type }
        end
      end
    end
  end
end