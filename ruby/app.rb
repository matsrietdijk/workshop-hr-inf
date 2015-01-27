require "rubygems"
require "bundler/setup"

require "sinatra"

get "/" do
    # the variable "title" containing the text "Hello World!"
    @title = "Hello World!"
    # render the template file "views/index.erb"
    erb :index
end
