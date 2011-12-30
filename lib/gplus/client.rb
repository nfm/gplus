require 'gplus/activity'
require 'gplus/comment'
require 'gplus/person'

module Gplus
  class Client
    DEFAULT_ENDPOINT = 'https://www.googleapis.com/plus'
    DEFAULT_API_VERSION = 'v1'

    attr_accessor :endpoint, :api_version

    # Create a Google+ API client. Read the {file:README.md README} to find learn about the different ways of initializing a client.
    #
    # @param [Hash] options
    # @option options [String] :api_key Your application's API key, used for non-authenticated requests (for public data).
    # @option options [String] :token The OAuth token to authorize the API client for authenticated requests (for non-public data). This can be supplied after initialization by calling {#authorize}.
    # @option options [String] :refresh_token The OAuth refresh_token, to request a new token if the provided token has expired.
    # @option options [Integer] :token_expires_at The time that the OAuth token expires at in seconds since the epoch.
    # @option options [String] :client_id Your application's Client ID. Required to generate an authorization URL with {#authorize_url}.
    # @option options [String] :client_secret Your application's Client Secret. Required to generate an authorization URL with {#authorize_url}.
    # @option options [String] :redirect_uri The default URI to redirect to after authorization. You can override this in many other methods. It must be specified as an authorized URI in your application's console. Required to generate an authorization URL with #authorize_url.
    # @return [Gplus::Client] A Google+ API client.
    def initialize(options = {})
      self.endpoint = DEFAULT_ENDPOINT
      self.api_version = DEFAULT_API_VERSION

      @api_key = options[:api_key]
      @token = options[:token]
      @refresh_token = options[:refresh_token]
      @token_expires_at = options[:token_expires_at]
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @redirect_uri = options[:redirect_uri]

      @oauth_client = OAuth2::Client.new(
        @client_id,
        @client_secret,
        :site => self.endpoint,
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
    #
    # @param [String] auth_code The code returned to your redirect_uri after the user authorized your application to access their Google+ data.
    # @param [String] redirect_uri An optional over-ride for the redirect_uri you initialized the API client with.
    # @return [OAuth2::AccessToken] An OAuth access token. Store access_token[:token] and access_token[:refresh_token] to get persistent access to the user's data until access_token[:expires_at].
    def authorize(auth_code, redirect_uri = @redirect_uri)
      @access_token = @oauth_client.auth_code.get_token(auth_code, :redirect_uri => redirect_uri)
    end

    # Retrieve or create an OAuth2::AccessToken, using the :token and :refresh_token specified when the API client instance was initialized
    #
    # @return An OAuth2::AccessToken
    def access_token
      if @token
        @access_token ||= OAuth2::AccessToken.new(@oauth_client, @token, :refresh_token => @refresh_token, :expires_at => @token_expires_at)
        if @access_token.expired?
          @access_token.refresh!
          @access_token_refreshed = true
        end
        @access_token
      end
    end

    # Return true if the user's access token has been refreshed. If so, you should store the new token's :token and :expires_at.
    def access_token_refreshed?
      @access_token_refreshed
    end

  private
    def get(path, params = {})
      if access_token
        response = access_token.get("#{self.api_version}/#{path}", params)
      else
        response = @oauth_client.request(:get, "#{self.api_version}/#{path}", { :params => params.merge(:key => @api_key) })
      end
      MultiJson.decode(response.body)
    end
  end
end
