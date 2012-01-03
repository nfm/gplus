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
  end
end
