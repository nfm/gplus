# gplus: A Google+ API client library for Ruby

## Intro

gplus is a complete implementation of the Google+ API, with help from OAuth2 and MultiJson.

I'm aiming to produce something light-weight, well documented, and thoroughly tested.

It currently has full support for the People and Activities APIs, using either OAuth requests for private data or API key requests for public data.

* [Documentation](http://rubydoc.info/github/nfm/gplus/master/frames)
* [Issues](https://github.com/nfm/gplus/issues)

## Installation

Add gplus to your Gemfile, then run `bundle install`.

    gem "gplus", "~> 0.3.1"

## Creating and configuring your application

To make requests, you need to [create an application](https://code.google.com/apis/console) with access to the Google+ API.

Next, [create an OAuth 2.0 client ID](http://code.google.com/apis/console#access). You'll need to pick a product name, an optional logo, and a domain to redirect to after authorization.

You can then specify additional redirect URIs and allowed javascript origins.

Currently, the Google+ API limits applications to 1,000 API requests per day. You can request an increase to this limit by visiting the [developer console](https://code.google.com/apis/console/) under the 'Quotas' section for your application.

## Unauthorized requests (for public data)

Create an API client using your API key:

    @client = Gplus::Client.new(
      :api_key => 'YOUR_API_KEY'
    )

You can now make requests for public data using the methods below for People and Activities.

## Authorized requests

First, create an API client using your Client ID, Client Secret, and one of the redirect URIs you have allowed:

    @client = Gplus::Client.new(
      :client_id => 'YOUR_CLIENT_ID',
      :client_secret => 'YOUR_CLIENT_SECRET',
      :redirect_uri => 'http://example.com/oauth/callback'
    )

Generate an authorization URL, and use it in a view:

    @auth_url = @client.authorization_url
    => https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri= ...

    = link_to 'Authorize This App', @auth_url

After the user authorizes your app, they will be redirected to your `redirect_uri`. Use `params[:code]` to retrieve an OAuth token for the user, and store the `token`, `refresh_token` and `expires_at` for persistence:

    class OauthController < ApplicationController
      def callback
        access_token = client.authorize(params[:code])
        current_user.update_attributes(
          :token => access_token.token,
          :refresh_token => access_token.refresh_token,
          :token_expires_at => access_token.expires_at
        )
      end
    end

Now you can create an authorized client instance using the stored OAuth token:

    @client = Gplus::Client.new(
      :token => current_user.token,
      :refresh_token => current_user.refresh_token,
      :token_expires_at => current_user.token_expires_at,
      :client_id => 'YOUR_CLIENT_ID',
      :client_secret => 'YOUR_CLIENT_SECRET',
      :redirect_uri => 'http://example.com/oauth/callback'
    )

## Refreshing OAuth tokens

Google+ OAuth tokens are currently only valid for 3600 seconds (one hour). You can use the `:refresh_token` to get a new OAuth token after your existing token expires, without requiring the user to re-authorize your application.

Gplus will automatically request a new token if the provided token has expired. You should check to see if this has occured so that you can store the new token. Otherwise, after the initial token expires, you'll be requesting a new token from Google each time you initialize an API client. This is slow!

You can determine whether a token has been refreshed by calling `access_token_refreshed?`:

    if @client.access_token_refreshed?
      access_token = @client.access_token
      current_user.update_attributes(
        :token => access_token.token,
        :token_expires_at => access_token.expires_at
      )
    end

The refreshed OAuth token will have `:refresh_token` set to `nil`. Keep using the initial `:refresh_token` you were given for all future refreshes.

## [People](http://developers.google.com/+/api/latest/people)

Get a person's profile with `client.get_person`:

    person = client.get_person(id)

You can use the id 'me' in place of a Person ID to fetch information about the user the client is authorized as.

The person's profile will be returned as a nested hash:

    person[:displayName]
    person[:urls].count
    person[:name][:middleName]

See the Google+ API documentation for [People](http://developers.google.com/+/api/latest/people) and [People: get](http://developers.google.com/+/api/latest/people/get) for more info.

## [Activities](http://developers.google.com/+/api/latest/activities)

Get an activity with `client.get_activity`:

    activity = client.get_activity(id)

The activity will be returned as a nested hash:

    activity[:actor][:displayName]
    activity[:object][:replies][:totalItems]
    activity[:attachments].each do { |a| a[:url] }

List a person's activities with `client.list_activities`:

    activities = client.list_activities(person_id)

The list will be returned as a nested hash. The actual activities are in the `:items` array:

    activities[:title]
    activities[:updated]
    activities[:items].each { |a| a.title }

By default, this will fetch 20 activities. You can fetch between 1 and 100 by passing a `:results` argument:

    # Get 80 results
    client.list_activities(id, :results => 80)

If you want more than 100 results, take the `:nextPageToken` returned from your first request, and pass it as a `:page` argument:

    activities = client.list_activities(id, :results => 100)
    more_activities = client.list_activities(id, :results => 100, :page => activities[:nextPageToken])

See the Google+ API documentation for [Activities](http://developers.google.com/+/api/latest/activities), [Activities: get](http://developers.google.com/+/api/latest/activities/get) and [Activities: list](http://developers.google.com/+/api/latest/activities/list).

## Contributing to gplus

Please submit bug reports as [Github Issues](https://github.com/nfm/Gplus/issues).

For bonus points, submit a pull request:

1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Commit and push your changes.
5. Submit a pull request. Please do not include changes to the gemspec or version.
