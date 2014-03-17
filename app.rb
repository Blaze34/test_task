# app.rb
require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///task.db"

class Request < ActiveRecord::Base
  validates :url, presence: true

  #def valid_url?
  #  false
  #end
end

get "/" do
  erb :"index"
end

get "/send" do
  status 200
  if params[:url]
    r = Request.new(url: params[:url])
    r.save
  end
  body params.to_s
end

get "/stats.?:format?" do
  if params[:format] == 'json'
    body '[{"qwerty":1}]'
  else
    erb :"stats"
  end
end

helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} -- Requests"
    else
      "My Ruby Project"
    end
  end

end