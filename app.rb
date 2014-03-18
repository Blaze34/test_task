# app.rb
require 'sinatra'
require 'missing_validators'
require 'sinatra/activerecord'
require_relative 'models/request'

set :database, 'sqlite3:///task.db'

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