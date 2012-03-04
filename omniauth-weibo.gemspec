require File.expand_path('../lib/omniauth-weibo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = "clc3123"
  gem.email         = "clc3123@gmail.com"
  gem.description   = %q{OmniAuth Oauth2 strategy for weibo.com.}
  gem.summary       = %q{OmniAuth Oauth2 strategy for weibo.com.}
  gem.homepage      = "https://github.com/clc3123/omniauth-weibo"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-weibo"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Weibo::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'
end
