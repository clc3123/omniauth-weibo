OmniAuth-Weibo
==============

This gem packs OmniAuth Oauth2 strategy for weibo.com.
It's a modification of OmniAuth-Github gem.

Basic Usage
-----------

In your Gemfile:

```ruby
gem 'omniauth-weibo', :git => ''
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
      <li>login: #{auth.uid}</li>
      <li>email: #{auth.info.name}</li>
    </ul>
  HTML
end
```
