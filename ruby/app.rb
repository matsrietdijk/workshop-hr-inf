require "rubygems"
require "bundler/setup"

require "sinatra/base"
require "sinatra/activerecord"
require "redcarpet"

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "workshop.sqlite3"
# create database tables
class DatabaseMigration < ActiveRecord::Migration
  drop_table :articles if ActiveRecord::Base.connection.table_exists? :articles
  create_table :articles do |t|
    t.string :title
    t.text :content
  end

  drop_table :authors if ActiveRecord::Base.connection.table_exists? :authors
  create_table :authors do |t|
    t.string :name
  end

  add_reference :articles, :author
end
# models
class Author < ActiveRecord::Base
  validates_presence_of :name
  has_many :articles, dependent: :destroy
end

class Article < ActiveRecord::Base
  validates_presence_of :title, :content
  belongs_to :author
end
# seed database
(1..3).each do |aut|
  author = Author.create name: "Author #{aut}"

  (1..10).each do |art|
    Article.create author_id: author.id, title: "Article #{author.id}.#{art}", content: "Lorem ipsum"
  end
end
# application
class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :public_folder ,"../static"

  get "/" do
    # the variable "title" containing the text "Hello World!"
    @title = "Hello World!"
    # render the template file "views/index.erb"
    erb :index
  end

  get "/about" do
    @authors = Author.all.order(name: :desc)
    erb :about
  end

  get "/task/:id" do
    id = params[:id]
    raw = File.read("../assignments/assignment-#{id}.md")
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @md = markdown.render(raw)
    erb :task
  end

  run!
end
