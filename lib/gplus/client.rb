require 'gplus/activity'
require 'gplus/person'

module Gplus
  class Client
    # Create a Google+ API client. Read the {file:README.md README} to find learn about the different ways of initializing a client.
    #
    # @param [Hash] options
    # @option options [String] :api_key Your application's API key, used for non-authenticated requests (for public data).
    # @option options [String] :token The OAuth token to authorize the API client for authenticated requests (for non-public data). This can be supplied after initialization by calling {#authorize}.
    # @option options [String] :client_id Your application's Client ID. Required to generate an authorization URL with {#authorize_url}.
    # @option options [String] :client_secret Your application's Client Secret. Required to generate an authorization URL with {#authorize_url}.
    # @option options [String] :redirect_uri The default URI to redirect to after authorization. You can override this in many other methods. It must be specified as an authorized URI in your application's console. Required to generate an authorization URL with #authorize_url.
    # @return [Gplus::Client] A Google+ API client.
    def initialize(options = {})
      @api_key = options[:api_key]
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @redirect_uri = options[:redirect_uri]
      @token = options[:token]

      @oauth_client = OAuth2::Client.new(
        @client_id,
        @client_secret,
        :site => 'https://www.googleapis.com/plus/',
        :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
        :token_url => 'https://accounts.google.com/o/oauth2/token'
      )
    end

    # Generate an authorization URL where a user can authorize your application to access their Google+ data.
    #
    # @param [String] redirect_uri An optional over-ride for the redirect_uri you initialized the API client with.
    # @return [String] A Google account authorization URL for your application.
    def authorize_url(redirect_uri = @redirect_uri)
      @oauth_client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => 'https://www.googleapis.com/auth/plus.me')
    end

    # Authorize an API client instance to access the user's private data.
    # @param [String] auth_code The code returned to your redirect_uri after the user authorized your application to access their Google+ data.
    # @param [String] redirect_uri An optional over-ride for the redirect_uri you initialized the API client with.
    # @return [OAuth2::AccessToken] An OAuth access token. Store access_token[:token] and access_token[:refresh_token] to get persistent access to the user's data until access_token[:expires_at].
    def authorize(auth_code, redirect_uri = @redirect_uri)
      @access_token = @oauth_client.auth_code.get_token(auth_code, :redirect_uri => redirect_uri)
    end

  private
    def access_token
      if @token
        @access_token ||= OAuth2::AccessToken.new(@oauth_client, @token)
      end
    end

    def get(path, params = {})
      if access_token
        response = access_token.get("v1/#{path}", params)
      else
        response = @oauth_client.request(:get, "v1/#{path}", { :params => params.merge(:key => @api_key) })
      end
      MultiJson.decode(response.body)
    end
  end
end
