module Gplus
  class Client
    def initialize(options = {})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @redirect_uri = options[:redirect_uri]

      @oauth_client = OAuth2::Client.new(
        @client_id,
        @client_secret,
        :site => 'https://www.googleapis.com/plus/',
        :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
        :token_url => 'https://accounts.google.com/o/oauth2/token'
      )
    end

    def authorize_url(redirect_uri = @redirect_uri)
      @oauth_client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => 'https://www.googleapis.com/auth/plus.me')
    end

    def authorize(auth_code, redirect_uri = @redirect_uri)
      @access_token = @oauth_client.auth_code.get_token(auth_code, :redirect_uri => redirect_uri)
    end
  end
end
