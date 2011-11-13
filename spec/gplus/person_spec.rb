require 'spec_helper'

describe Gplus::Client do
  before do
    @api_key = '1234567'
    @client = Gplus::Client.new(:api_key => @api_key)

    @person, @person_json = fixture('person.json')
  end

  describe '.get_person' do
    it "should return a person's profile" do
      stub_api_request(:get, "people/#{@person_json['id']}").to_return(:body => @person)
      @client.get_person(@person_json['id']).should == @person_json
    end
  end

  describe '.search_people' do
    before do
      @people, @people_json = fixture('people.json')
    end

    it "should list all public profiles" do
      stub_api_request(:get, "people").to_return(:body => @people)
      @client.search_people.should == @people_json
    end

    it "should accept a :query argument" do
      stub_api_request(:get, "people", :query => @person_json['displayName']).to_return(:body => @person)
      @client.search_people(:query => @person_json['displayName']).should == @person_json
    end

    it "should accept a :maxResults argument" do
      @results = 2

      stub_api_request(:get, "people", :maxResults => @results.to_s).to_return(:body => @people)
      @client.search_people(:maxResults => @results).should == @people_json
    end

    it "should accept a :pageToken argument" do
      @page = '1234567'

      stub_api_request(:get, "people", :pageToken => @page).to_return(:body => @people)
      @client.search_people(:pageToken => @page).should == @people_json
    end
  end
end
