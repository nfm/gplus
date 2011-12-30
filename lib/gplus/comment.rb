module Gplus
  # A collection of methods for Google+ Comments API calls.
  # @see https://developers.google.com/+/api/latest/comments The Google+ Comments documentation
  module Comment
    # Get a Comment by its unique ID.
    # @see https://developers.google.com/+/api/latest/comments/get The Google+ 'Comments: get' documentation
    #
    # @param [String] id The unique ID of the comment you want to retrieve.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/comments#resource Comment resource}.
    def get_comment(id)
      get("comments/#{id}")
    end

    # List an activity's comments.
    # @see https://developers.google.com/+/api/latest/comments/list The Google+ 'Comments: list' documentation.
    # @see https://developers.google.com/+/api/#pagination The Google+ pagination documentation.
    #
    # @param [String] activity_id The unique ID of the activity whose comments you want to list.
    # @option options [Integer] maxResults (20) The number of comments, between 0 and 100, to return.
    # @option options [String] pageToken The page of comments to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/comments/list#response list of comments}.
    def list_comments(activity_id, options = {})
      get("activities/#{activity_id}/comments", options)
    end
  end
end
