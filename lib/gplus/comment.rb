module Gplus
  class Client
    # Get a Comment by its unique ID.
    # See https://developers.google.com/+/api/latest/comments/get for more details.
    #
    # @param [String] id The unique ID of the comment you want to retrieve.
    # @returb [Hash] A nested hash representation of a {https://developers.google.com/+/api/latest/comments Comment resource}.
    def get_comment(id)
      get("comments/#{id}")
    end

    # List an activity's comments.
    # See http://developers.google.com/+/api/latest/comments/list for more details.
    #
    # @param [String] activity_id The unique ID of the activity whose comments you want to list.
    # @param [Integer] results The number of comments, between 1 and 100, to return.
    # @param [String] page The page of comments to fetch. Pass the value of :nextPageToken from the previous result set to get the next page of results.
    # @return [Hash] A nested hash representation of a {http://developers.google.com/+/api/latest/comments/list list of comments}.
    def list_comments(activity_id, results = 20, page = nil)
      get("activities/#{activity_id}/comments", { :maxResults => results, :pageToken => page })
    end
  end
end
