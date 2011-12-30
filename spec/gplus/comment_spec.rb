require 'spec_helper'

describe Gplus::Comment do
  before do
    @api_key = '1234567'
    @client = Gplus::Client.new(:api_key => @api_key)
  end

  describe '.get_comment' do
    it "should return a comment" do
      comment, comment_json = fixture('comment.json')

      stub_api_request(:get, "comments/#{comment_json['id']}").to_return(:body => comment)
      @client.get_comment(comment_json['id']).should == comment_json
    end
  end

  describe '.list_comments' do
    before do
      @activity, @activity_json = fixture('activity.json')
      @comments, @comments_json = fixture('comments.json')
    end

    it "should return a list of an activity's public comments" do
      stub_api_request(:get, "activities/#{@activity_json['id']}/comments").to_return(:body => @comments)
      @client.list_comments(@activity_json['id']).should == @comments_json
    end

    it "should accept a :maxResults argument" do
      @results = 2

      stub_api_request(:get, "activities/#{@activity_json['id']}/comments", :maxResults => @results.to_s).to_return(:body => @comments)
      @client.list_comments(@activity_json['id'], :maxResults => @results).should == @comments_json
    end

    it "should accept a :pageToken argument" do
      @page = '1234567'

      stub_api_request(:get, "activities/#{@activity_json['id']}/comments", :pageToken => @page).to_return(:body => @comments)
      @client.list_comments(@activity_json['id'], :pageToken => @page).should == @comments_json
    end
  end
end
