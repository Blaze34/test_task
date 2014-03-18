require 'support/active_record'
require_relative '../models/request'

describe Request do

  before(:each) do
    @request = Request.new
  end

  it 'requires a valid url' do
    @request.should have(2).error_on(:url)
    @request.url = 'foo'
    @request.should have(1).error_on(:url)
    @request.url = 'http://google.com'
    @request.should have(:no).errors_on(:url)
  end

  it 'save request' do
    @request.url = 'http://google.com'
    @request.save.should == true
  end

  it 'checking stats' do

    @request.url = 'http://google.com'
    @request.save

    stats = Request.stats
    stats.should be_a(Hash)

    stats.each_value do |v|
      v.should > 0
    end
  end

end