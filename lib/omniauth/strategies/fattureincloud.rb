require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fattureincloud < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "fattureincloud"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => "https://api-v2.fattureincloud.it/",
        :authorize_url => "https://api-v2.fattureincloud.it/oauth/authorize",
        :token_url => "https://api-v2.fattureincloud.it/oauth/token"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info["data"]["id"] }

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get("/user/info").parsed
      end
    end
  end
end
