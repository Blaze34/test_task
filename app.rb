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
end

get "/stats" do
    erb :"stats"
end

get "/json" do
    #group by
    body Request.all.to_json
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