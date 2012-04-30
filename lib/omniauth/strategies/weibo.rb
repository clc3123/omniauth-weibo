require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      args [:client_id, :client_secret]

      option :client_options, {
        :site            => "https://api.weibo.com",
        :authorize_url   => "/oauth2/authorize",
        :token_url       => "/oauth2/access_token",
      }
      option :authorize_params,  {}
      option :authorize_options, []
      option :token_params,      {}
      option :token_options,     []

      uid do
        @user_id = access_token.params[:uid] || access_token.params['uid']
      end

      info do
        {
          :nickname => raw_info['screen_name'],
          :avatar => raw_info['avatar_large'],
          :gender => raw_info['gender'] == 'm' ? 'm' : 'w'
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      # There's a little bug concerning token expiration time in
      # credentials block which is caused by Oauth2 gem during
      # access_token object initialization. But I don't care because
      # that's useless at least for now.

      def raw_info
        @raw_info ||= access_token.get(
          '/2/users/show.json', :params => {:uid => @user_id}
        ).parsed
      end

      protected

      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(
          verifier,
          {:redirect_uri => callback_url, :parse => :json},
          {:mode => :query, :param_name => 'access_token'}
        )
      end
    end
  end
end

OmniAuth.config.add_camelization "weibo", "Weibo"
