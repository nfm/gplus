require 'spec_helper'

describe Gplus::Client do
  before do
    @api_key = '1234567'
    @client = Gplus::Client.new(:api_key => @api_key)
  end

  describe '.get_activity' do
    it "should return an activity" do
      activity, activity_json = fixture('activity.json')

      stub_api_request(:get, "activities/#{activity_json['id']}").to_return(:body => activity)
      @client.get_activity(activity_json['id']).should == activity_json
    end
  end

  describe '.list_activities' do
    before do
      @person, @person_json = fixture('person.json')
      @activities, @activities_json = fixture('activities.json')
    end

    it "should return a list of a person's public activities" do
      stub_api_request(:get, "people/#{@person_json['id']}/activities/public").to_return(:body => @activities)
      @client.list_activities(@person_json['id']).should == @activities_json
    end

    it "should accept a :maxResults argument" do
      @results = 2

      stub_api_request(:get, "people/#{@person_json['id']}/activities/public", :maxResults => @results.to_s).to_return(:body => @activities)
      @client.list_activities(@person_json['id'], :maxResults => @results).should == @activities_json
    end

    it "should accept a :pageToken argument" do
      @page = '1234567'

      stub_api_request(:get, "people/#{@person_json['id']}/activities/public", :pageToken => @page).to_return(:body => @activities)
      @client.list_activities(@person_json['id'], :pageToken => @page).should == @activities_json
    end
  end

  describe '.search_activities' do
    before do
      @activity, @activity_json = fixture('activity.json')
      @activities, @activities_json = fixture('activities.json')
    end

    it "should list all public activities" do
      stub_api_request(:get, "activities").to_return(:body => @activities)
      @client.search_activities.should == @activities_json
    end

    it "should accept a :query argument" do
      stub_api_request(:get, "activities", :query => @activity_json['title']).to_return(:body => @activity)
      @client.search_activities(:query => @activity_json['title']).should == @activity_json
    end

    it "should accept a :maxResults argument" do
      @results = 2

      stub_api_request(:get, "activities", :maxResults => @results.to_s).to_return(:body => @activities)
      @client.search_activities(:maxResults => @results).should == @activities_json
    end

    it "should accept a :pageToken argument" do
      @page = '1234567'

      stub_api_request(:get, "activities", :pageToken => @page).to_return(:body => @activities)
      @client.search_activities(:pageToken => @page).should == @activities_json
    end
  end
end
