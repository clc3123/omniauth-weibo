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

      option :authorize_options, [:display, :state]

      option :token_params, {
        :parse => :json
      }

      option :token_options, []

      def request_phase
        # If you needs to implement CSRF protection, maybe you
        # need to set the state param in the authorization url,
        # which will be sent back as param within the callback url
        # when the user-agent redirect after authorization. 
        # Add codes here if you want to do so. But OmniAuth-Oauth2's 
        # default strategy for the request_phase is just fine while
        # it adds client_id, redirect_uri and response_type in the
        # authorization url. Also if you want to specify the display
        # type of authorization window for the user-agent.
        super
      end
      
      def callback_phase
        super
      end

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
