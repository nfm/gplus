# Changelog

## v2.0.0: 2012/01/03

### Breaking API changes

* Rename `#authorize` to `#get_token` and change method signature to match `OAuth2::Strategy::AuthCode#get_token`.
  Convert `access_token = authorize(params[:code])` to `access_token = get_token(params[:code])` in your OAuth callback action.
* Define new `#authorize` method, for authorization a client instance with a user's `token`, `refresh_token` and `token_expires_at` after initialization.
* `#search_people` and `#search_activities` now take a mandatory query parameter, followed by an options hash.
  Convert `search_people(:query => 'Frankie', :maxResults => 5)` to `search_people('Frankie', :maxResults => 5)`.
* `#authorize_url` now accepts an options hash, instead of just a `redirect_uri` parameter. Use the options hash to request a different `access_type` amongst other things.
  Convert `authorize_url('http://example.org/callback')` to `authorize_url(:redirect_uri => 'http://example.org/callback')`.

### Other changes

* Bugfix: Authorized requests with params now call OAuth2 methods correctly
* Bugfix: Fixed access token refreshing
* `Activity`, `Comment` and `Person` are now modules included in `Client`
* Better YARD documentation
* Files are now autoloaded
* Added link to Rails 3.1 example app

## v1.0.1: 2011/12/30

* Fix bug in `#access_token` where `@access_token` was not being returned correctly
* Fix incorrect method name in README

## v1.0.0: 2011/11/13

* Add support for searching for People and Activities
* Full test coverage of People, Activity and Comment methods
* Change `#list_activities` and `#list_comments` methods to take an options hash rather than separate :results and :page arguments

## v0.5.0: 2011/10/15

* Add support for the Comments API
* Stub out rspec examples
* Improve README

## v0.4.0: 2011/09/18

* Handle refreshing of OAuth tokens

## v0.3.1: 2011/09/17

* Add YARD documentation for all public methods

## v0.3.0: 2011/09/17

* API key based requests for public data

## v0.2.2: 2011/09/16

* Bug fixes

## v0.2.1: 2011/09/16

* Bug fixes

## v0.2.0: 2011/09/16

* Add support for the Activities API

## v0.1.0: 2011/09/16

* Add support for OAuth authorization for non-public data
* Add support for the People API
