OmniAuth-Weibo
==============

This gem packs OmniAuth Oauth2 strategy for weibo.com.
It's a modification of OmniAuth-Github gem.

Basic Usage
-----------

In your Gemfile:

```ruby
gem 'omniauth', '~> 1.0'
gem 'oauth2',          :git => 'git://github.com/chefchen/oauth2.git'
gem 'omniauth-oauth2', :git => 'git://github.com/chefchen/omniauth-oauth2.git'
gem 'omniauth-weibo',  :git => 'git://github.com/chefchen/omniauth-weibo.git'
```

A sample app:

```ruby
# encoding: utf-8

require 'sinatra'
require 'omniauth'
require 'omniauth-weibo'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :weibo, ENV['APP_KEY'], ENV['APP_SECRET']
end

get '/' do
  <<-HTML
    <a href="/auth/weibo">Login Using Weibo!</a>
  HTML
end

get '/auth/weibo/callback' do
  auth = request.env['omniauth.auth']

  <<-HTML
    <ul>
      <li>uid: #{auth.uid}</li>
      <li>nickname: #{auth.info.nickname}</li>
      <li>gender: #{auth.info.gender}</li>
    </ul>
  HTML
end
```
