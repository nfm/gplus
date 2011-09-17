module Gplus
  class Client
    # Get a person's Google+ profile.
    # See http://developers.google.com/+/api/latest/people/get for more details.
    #
    # @param [String] id The unique ID of the person whose profile you want to retrieve. Pass the string 'me' to fetch the profile for the person that the API client is authorized as.
    # @return [Hash] A nested hash representation of a {http://developers.google.com/+/api/latest/people/get Person resource}
    def get_person(id)
      get("people/#{id}")
    end
  end
end
