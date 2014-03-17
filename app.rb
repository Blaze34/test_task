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
  @test = params
end

get "/stats" do
  erb :"stats"
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