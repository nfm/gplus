require 'spec_helper'

describe Gplus::Client do
  before do
    @api_key = '1234567'
    @client = Gplus::Client.new(:api_key => @api_key)
  end

  describe '.get_person' do
    it "should return a person's profile" do
      person, person_json = fixture('person.json')
      stub_api_request(:get, "people/#{person_json['id']}").to_return(:body => person)
      @client.get_person(person_json['id']).should == person_json
    end
  end
end
