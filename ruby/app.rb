require "rubygems"
require "bundler/setup"

require "sinatra/base"
require "sinatra/activerecord"

class Author < ActiveRecord::Base
  validates_presence_of :name
end

class Article < ActiveRecord::Base
  validates_presence_of :title, :content
end

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :database, { adapter: "sqlite3", database: ":memory:" }

  get "/" do
    # the variable "title" containing the text "Hello World!"
    @title = "Hello World!"
    # render the template file "views/index.erb"
    erb :index
  end

  run!
end
