lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ding_talk/version"

Gem::Specification.new do |spec|
  spec.name          = "ding_talk"
  spec.version       = DingTalk::VERSION
  spec.authors       = ["xubh"]
  spec.email         = ["xubh@wikiflyer.cn"]

  spec.summary       = %q{Ruby API wrapper for ding talk「钉钉」}
  spec.description   = %q{doing}
  spec.homepage      = "https://gitee.com/bulexu/ding_talk"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'http', '>= 2.2'
  spec.add_dependency 'activesupport', '>= 5.0'
  spec.add_dependency 'redis'
  spec.add_dependency 'builder', '>= 3.2'
  spec.add_dependency 'sinatra', '>= 2.0'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency 'mock_redis', '~>0.18'
end
