module Gplus
  # A collection of methods for Google+ People API calls.
  # @see https://developers.google.com/+/api/latest/people The Google+ People documentation.
  module Person
    # Get a person's Google+ profile.
    # @ https://developers.google.com/+/api/latest/people/get The Google+ 'People: get' documentation.
    #
    # @param [String] id The unique ID of the person whose profile you want to retrieve. Pass the string 'me' to fetch the profile for the person that the API client is authorized as.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/people#resource Person resource}
    def get_person(id)
      get("people/#{id}")
    end

    # Search all public Google+ profiles.
    # @see https://developers.google.com/+/api/latest/people/search The Google+ 'People: search' documentation.
    # @see https://developers.google.com/+/api/#pagination The Google+ pagination documentation.
    #
    # @param [String] query The full text query to search for.
    # @option options [String] language The preferred language to search with. See {https://developers.google.com/+/api/search#available-languages the official list of allowed language codes}.
    # @option options [Integer] maxResults (10) The number of profiles, between 1 and 20, to return.
    # @option options [String] pageToken The page of profiles to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/people/search#response search result for people}.
    def search_people(query, options = {})
      get("people", options.merge(:query => query))
    end

    # List all of the people in the specified collection for a particular activity.
    # @see https://developers.google.com/+/api/latest/people/listByActivity The Google+ 'People: listByActivity' documentation.
    # @see https://developers.google.com/+/api/#pagination The Google+ pagination documentation.
    #
    # @param [String] activity_id The ID of the activity to get the list of people for.
    # @param [String] collection The collection of people to list. Acceptable values are 'plusoners' and 'resharers'.
    # @option options [Integer] maxResults (20) The number of people, between 1 and 100, to return.
    # @option options [String] pageToken The page of people to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/people/listByActivity#response list of people}.
    def list_people_by_activity(activity_id, collection, options = {})
      get("activities/#{activity_id}/people/#{collection}", options)
    end
  end
end
