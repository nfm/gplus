# Gplus: A Google+ API client library for Ruby

## Intro

GPlus is a complete implementation of the Google+ API, with help from OAuth2 and MultiJson.

I'm aiming to produce something light-weight, well documented, and thoroughly tested.

It currently has full support for People and Activities, and for authorized requests.

## Installation

Add GPlus to your Gemfile, then run `bundle install`.

    gem "gplus", "~> 0.2.0"

## Creating and configuring your application

To make requests, you need to [create an application](https://code.google.com/apis/console) with access to the Google+ API.

Next, [create an OAuth 2.0 client ID](http://code.google.com/apis/console#access). You'll need to pick a product name, an optional logo, and a domain to redirect to after authorization.

You can then specify additional redirect URIs and allowed javascript origins.

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

After the user authorizes your app, they will be redirected to your `redirect_uri`. Store `params[:code]`:

    class OauthController < ApplicationController
      def callback
        current_user.update_attributes(:oauth_code => params[:code])
      end
    end

Finally, create an authorized client instance:

    client.authorize(current_user.oauth_code)

If you have an OAuth code stored, you can use it to initialize your API client:

    @client = Gplus::Client.new(
      :token => current_user.oauth_code,
    )

## [People](http://developers.google.com/+/api/latest/people)

Get a person's profile with `client.get_person`:

    person = client.get_person(id)

You can use the id 'me' in place of a Person ID to fetch information about the user the client is authorized as.

The person's profile will be returned as a nested hash:

    person[:displayName]
    person[:urls].count
    person[:name][:middleName]

See the API documentation for [People](http://developers.google.com/+/api/latest/people) and [People: get](http://developers.google.com/+/api/latest/people/get) for more info.

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

See the API documentation for [Activities](http://developers.google.com/+/api/latest/activities), [Activities: get](http://developers.google.com/+/api/latest/activities/get) and [Activities: list](http://developers.google.com/+/api/latest/activities/list).

## Contributing to Gplus

Please submit bug reports as [Github Issues](https://github.com/nfm/Gplus/issues).

For bonus points, submit a pull request:

1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Commit and push your changes.
5. Submit a pull request. Please do not include changes to the gemspec or version.
