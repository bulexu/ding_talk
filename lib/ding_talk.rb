require 'redis'
require 'active_support/all'

LIB_PATH = "#{File.dirname(__FILE__)}/ding_talk"
Dir["#{LIB_PATH}/api/methods/*.rb",  "#{LIB_PATH}/token/*.rb"].each { |path| require path }

require "ding_talk/version"
require 'ding_talk/cipher'
require 'ding_talk/config'
require 'ding_talk/api/base'
require 'ding_talk/api/agent'

module DingTalk
  AUTHORIZE_ENDPOINT        = 'https://oapi.dingtalk.com/'.freeze
  AUTHORIZE_ENDPOINT_V2     = 'https://api.dingtalk.com/'.freeze
  HTTP_OK_STATUS          = [200, 201].freeze
  SUCCESS_CODE            = 0

  # Exceptions
  class RedisNotConfigException < RuntimeError; end
  class AccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
end
