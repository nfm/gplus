require 'simplecov'
SimpleCov.start

require 'rspec'
require 'webmock/rspec'

require 'gplus'

def fixture(file)
  text = File.read(File.join(File.expand_path('../fixtures', __FILE__), file))
  [text, MultiJson.decode(text)]
end

def stub_api_request(method, path, query = {})
  query[:key] = @api_key unless @api_key.blank?
  stub_request(method, "#{Gplus::Client::DEFAULT_ENDPOINT}/#{Gplus::Client::DEFAULT_API_VERSION}/#{path}").with(:query => query)
end
