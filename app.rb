# app.rb
require 'sinatra'
require 'missing_validators'
require 'sinatra/activerecord'

set :database, 'sqlite3:///task.db'

class Request < ActiveRecord::Base
  validates :url, presence: true, url: true

  class << self
    def stats
      data = Hash.new(0)

      select('COUNT(*) as count, sent, success').group('sent, success').each do |r|
        data[ r[:success] ? :success : :fail] += r[:count] if r[:sent]

        data[:total] += r[:count]
      end

      data
    end
  end
end

get '/' do
  erb :'index'
end

get '/send' do
  Request.create(url: params[:url]) if params[:url]
end

get '/stats' do
    erb :'stats'
end

get '/json' do
  body Request.stats.to_json
end

helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      '#{@title} -- Requests'
    else
      'My Ruby Project'
    end
  end

end