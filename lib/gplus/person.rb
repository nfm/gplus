module Gplus
  class Client
    def get_person(id)
      get("people/#{id}")
    end
  end
end
