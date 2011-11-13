module Gplus
  class Client
    # Get an Activity by its unique ID.
    # See http://developers.google.com/+/api/latest/activities/get for more details.
    #
    # @param [String] id The unique ID of the activity you want to retrieve.
    # @return [Hash] A nested hash representation of an {http://developers.google.com/+/api/latest/activities Activity resource}.
    def get_activity(id)
      get("activities/#{id}")
    end

    # List a Person's Google+ activities.
    # See http://developers.google.com/+/api/latest/activities/list for more details.
    #
    # @param [String] person_id The unique ID of the person whose activities you want to list. Pass the string 'me' to list the activities for the person that the API client is authorized as.
    # @option options [Integer] maxResults The number of activities, between 1 and 100, to return.
    # @option options [String] pageToken The page of activities to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of {http://developers.google.com/+/api/latest/activities/list list of activities}.
    def list_activities(person_id, options = {})
      get("people/#{person_id}/activities/public", options)
    end
  end
end
