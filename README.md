# Gplus: A Google+ API client library for Ruby

## Intro

The Google+ API was opened today (15th September 2011).

So far, there are two stub gems, `googleplus` and `google_plus`, both of which do literally nothing.

Lets work together to get Ruby on Google+ ASAP!

## Installation

gem install gplus

## Creating and configuring your application

To make requests, you need to [create an application](https://code.google.com/apis/console) with access to the Google+ API.

Next, [create an OAuth 2.0 client ID](http://code.google.com/apis/console#access). You'll need to pick a product name, an optional logo, and a domain to redirect to after authorization.

You can then specify additional redirect URIs and allowed javascript origins.

You'll need the Client ID and Client secret that are generated. Keep them secure!

## Authorized requests

Create an instance of the client using the credentials from when you set up your application:

    @client = Gplus::Client.new(
      :client_id => 'YOUR_CLIENT_ID',
      :client_secret => 'YOUR_CLIENT_SECRET',
      :redirect_uri => 'http://example.com/oauth2callback'
    )

Generate an authorization URL, and use it in a view:

    @auth_url = @client.authorization_url
    => https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri= ...

    = link_to 'Authorize This App', @auth_url

After the user authorizes your app, they will be redirected to your `redirect_uri`. Store `params[:code]`:

    def oauth_callback_handler
      current_user.update_attributes(:oauth_code => params[:code])
    end

Finally, create an authorized client instance:

    client.authorize(current_user.oauth_code)

## [People](http://developers.google.com/+/api/latest/people)

Get a person's profile with `client.get_person`:

    client.get_person('userId')

    client.get_person('me')

The person's profile will be returned as a nested hash:

    person[:displayName]
    person[:urls].count
    person[:name][:middleName]
