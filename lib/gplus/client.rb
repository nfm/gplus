module Gplus
  class Client
    def initialize(options = {})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
    end
  end
end
