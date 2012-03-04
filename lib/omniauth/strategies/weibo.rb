require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site          => "https://api.weibo.com",
        :authorize_url => "/oauth2/authorize",
        :token_url     => "/oauth2/access_token"
      }

      option :authorize_params, {}
      option :authorize_options, []

      option :token_params, {:parse => :json}
      option :token_options, []
      option :token_formatter, lambda {|hash|
        hash[:avaliable_for] = hash[:expires_in]
        hash[:expires_in] = hash[:remind_in]
      }

      uid do
        raw_info["uid"]
      end

      info do
        {
          :nickname => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get('/2/users/show.json').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization "weibo", "Weibo"
