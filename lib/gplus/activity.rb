module Gplus
  module Activity
    def get_activity(id)
      get("activities/#{id}")
    end

    def list_activities(person_id, results = 20, page = nil)
      get("people/#{person_id}/activities/public?maxResults=#{results}&pageToken=#{page}")
    end
  end
end
