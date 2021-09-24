# DingTalk 钉钉接口服务  

[钉钉文档](https://developers.dingtalk.com/document/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ding_talk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ding_talk

## Usage

### 初始化

```
DingTalk.configure do |config|
  config.redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_CACHE_DB'])   # redis
  config.http_timeout_options = {write: 15, read: 15, connect: 10}                                        # 请求超时
  config.expired_shift_seconds = 180                                                                      # access token 有效期偏移量 (时间有效期 - 偏移量)
end
```

### 内部应用

初始化接口 [DingTalk::Api::Agent](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/agent.rb)

``` ruby
$agent_api = DingTalk::Api::Agent.new(
      corp_id: ENV['CORP_ID'],  # 企业ID
      agent_id: ENV['AGENT_ID'],  # 应用ID
      app_key: ENV['APP_KEY'],  # 应用app_key
      app_secret: ENV['APP_SECRET']  # 应用app_secret
    )
```

## 已实现接口列表

[DingTalk::Api::Methods::User](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/methods/user.rb)

[DingTalk::Api::Methods::Department](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/methods/department.rb)

[DingTalk::Api::Methods::Chat](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/methods/chat.rb)

[DingTalk::Api::Methods::Message](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/methods/message.rb)

[DingTalk::Api::Methods::Media](https://gitee.com/bulexu/ding_talk/blob/master/lib/ding_talk/api/methods/media.rb)

## Development

* Fork `DingTalk` on Gitee/GitHub
* Make your changes
* Ensure all tests pass (`rake spec`)
* Send a pull request
* If we like them we'll merge them
* If we've accepted a patch, feel free to ask for commit access!

## Contributing

Bug reports and pull requests are welcome on Gitee at https://gitee.com/bulexu/ding_talk.  
Bug reports and pull requests are welcome on GitHub at https://github.com/bulexu/ding_talk.
