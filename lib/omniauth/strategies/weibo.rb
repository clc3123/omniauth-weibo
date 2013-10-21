require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      # args [:client_id, :client_secret]

      option :client_options, {
        site:          "https://api.weibo.com",
        authorize_url: "/oauth2/authorize",
        token_url:     "/oauth2/access_token",
      }
      # http://open.weibo.com/wiki/Oauth2/authorize
      option :authorize_options, [:scope, :display, :forcelogin, :language]
      option :token_params,      {parse: json}

      uid do
        raw_info['id']
      end

      info do
        {
          nickname: raw_info['screen_name']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= begin
          user_id = access_token.params['uid'] || access_token.params[:uid]
          access_token.options[:mode] = :query
          access_token.options[:param_name] = 'access_token'
          access_token.get('/2/users/show.json', params: {uid: user_id}, parse: :json).parsed
        end
      end

      protected

      # Customize authorize_params through request params.
      # It will override those hard coded options during middleware initialization.
      def authorize_params
        options.authorize_options.each do |option|
          if o = request.params[option.to_s]
            options[option] = o
          end
        end
        super
      end
    end
  end
end

OmniAuth.config.add_camelization "weibo", "Weibo"
