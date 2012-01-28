require 'spec_helper'

describe Gplus::Person do
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

    it "should require a :query parameter" do
      stub_api_request(:get, "people", :query => @person_json['displayName']).to_return(:body => @person)
      @client.search_people(@person_json['displayName']).should == @person_json
    end

    it "should accept a :maxResults option" do
      @results = 2

      stub_api_request(:get, "people", :query => @person_json['displayName'], :maxResults => @results.to_s).to_return(:body => @people)
      @client.search_people(@person_json['displayName'], :maxResults => @results).should == @people_json
    end

    it "should accept a :pageToken option" do
      @page = '1234567'

      stub_api_request(:get, "people", :query => @person_json['displayName'], :pageToken => @page).to_return(:body => @people)
      @client.search_people(@person_json['displayName'], :pageToken => @page).should == @people_json
    end
  end

  describe '.list_people_by_activity' do
    before do
      @activity, @activity_json = fixture('activity.json')
      @people, @people_json = fixture('people.json')
    end

    it "should return a list of people who reshared an activity" do
      stub_api_request(:get, "activities/#{@activity_json['id']}/people/resharers").to_return(:body => @people)
      @client.list_people_by_activity(@activity_json['id'], 'resharers').should == @people_json
    end

    it "should return a list of people who plusoned an activity" do
      stub_api_request(:get, "activities/#{@activity_json['id']}/people/plusoners").to_return(:body => @people)
      @client.list_people_by_activity(@activity_json['id'], 'plusoners').should == @people_json
    end

    it "should accept a :maxResults argument" do
      @results = 2

      stub_api_request(:get, "activities/#{@activity_json['id']}/people/plusoners", :maxResults => @results.to_s).to_return(:body => @people)
      @client.list_people_by_activity(@activity_json['id'], 'plusoners', :maxResults => @results).should == @people_json
    end

    it "should accept a :pageToken argument" do
      @page = '1234567'

      stub_api_request(:get, "activities/#{@activity_json['id']}/people/plusoners", :pageToken => @page).to_return(:body => @people)
      @client.list_people_by_activity(@activity_json['id'], 'plusoners', :pageToken => @page).should == @people_json
    end
  end
end
