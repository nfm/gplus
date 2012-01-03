module Gplus
  # A collection of methods for Google+ Activities API calls.
  # @see https://developers.google.com/+/api/latest/activities The Google+ Activities documentation.
  module Activity
    # Get an Activity by its unique ID.
    # @see https://developers.google.com/+/api/latest/activities/get The Google+ 'Activities: get' documentation.
    #
    # @param [String] id The unique ID of the activity you want to retrieve.
    # @return [Hash] A nested hash representation of an {https://developers.google.com/+/api/latest/activities#resource Activity resource}.
    def get_activity(id)
      get("activities/#{id}")
    end

    # List a Person's Google+ activities.
    # @see https://developers.google.com/+/api/latest/activities/list The Google+ 'Activities: list' documentation.
    # @see https://developers.google.com/+/api/#pagination The Google+ pagination documentation.
    #
    # @param [String] person_id The unique ID of the person whose activities you want to list. Pass the string 'me' to list the activities for the person that the API client is authorized as.
    # @option options [Integer] maxResults (20) The number of activities, between 1 and 100, to return.
    # @option options [String] pageToken The page of activities to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/activities/list#response list of activities}.
    def list_activities(person_id, options = {})
      get("people/#{person_id}/activities/public", options)
    end

    # Search all public Google+ activities.
    # @see https://developers.google.com/+/api/latest/activities/search The Google+ 'Activities: search' documentation.
    #
    # @param [String] query The full text query to search for.
    # @option options [Integer] maxResults (10) The number of activities, between 1 and 20, to return.
    # @option options [String] pageToken The page of activities to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @option options [String] orderBy ('recent') Specifies how to order search results. Acceptable values are 'best' and 'recent'.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/activities/search#response search result for activities}.
    def search_activities(query, options = {})
      get("activities", options.merge(:query => query))
    end
  end
end
