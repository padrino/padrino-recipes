# Template for Sample Blog tutorial at http://www.padrinorb.com/guides/blog-tutorial but using datamapper
project :test => :shoulda, :renderer => :haml, :stylesheet => :sass, :script => :jquery, :orm => :datamapper

# Default routes
APP_INIT = <<-APP
  get "/" do
    "Hello World!"
  end

  get :about, :map => '/about_us' do
    render :haml, "%p This is a sample blog created to demonstrate the power of Padrino!"
  end
APP
inject_into_file 'app/app.rb', APP_INIT, :before => "#\n  end\n"

# Generating padrino admin
inject_into_file 'Gemfile', "gem 'bcrypt-ruby', :require => 'bcrypt'\n", :after => "# Component requirements\n"
run_bundler
generate :admin
rake "dm:create dm:migrate seed"

# appending timestamps to post model
generate :model, "post title:string body:text"
inject_into_file 'db/migrate/002_create_posts.rb',"      t.timestamps\n",:after => "t.text :body\n"
rake 'dm:migrate'

# Generating posts controller
generate :controller, "posts get:index get:show"
gsub_file('app/controllers/posts.rb', /^\s+\#\s+.*\n/,'')
POST_INDEX_ROUTE = <<-POST
      @posts = Post.all(:order => 'created_at desc')
      render 'posts/index'
POST
POST_SHOW_ROUTE = <<-POST
      @post = Post.find_by_id(params[:id])
      render 'posts/show'
POST
inject_into_file 'app/controllers/posts.rb', POST_INDEX_ROUTE, :after => "get :index do\n"
inject_into_file 'app/controllers/posts.rb', POST_SHOW_ROUTE, :after => "get :show do\n"
inject_into_file 'app/controllers/posts.rb', ", :with => :id", :after => "get :show" # doesn't run?

# Generate admin_page for post
generate :admin_page, "post"

# Migrations to add account to post
generate :migration, "AddAccountToPost account_id:integer"

# Update Post Model with Validations and Associations
POST_MODEL = <<-POST
  belongs_to :account
  validates_presence_of :title
  validates_presence_of :body
POST
inject_into_file 'models/post.rb', POST_MODEL, :after => "DataMapper::Resource\n"
rake 'dm:migrate'

# Update admin app controller for post
inject_into_file 'admin/controllers/posts.rb',"    @post.account = current_account\n",:after => "new(params[:post])\n"

# Include RSS Feed
inject_into_file 'app/controllers/posts.rb', ", :provides => [:html, :rss, :atom]", :after => "get :index"

# Create index.haml
POST_INDEX = <<-POST
- @title = "Welcome"

- content_for :include do
  = feed_tag(:rss, url(:posts, :index, :format => :rss),:title => "RSS")
  = feed_tag(:atom, url(:posts, :index, :format => :atom),:title => "ATOM")

#posts= partial 'posts/post', :collection => @posts
POST
create_file 'app/views/posts/index.haml', POST_INDEX

# Create _post.haml
POST_PARTIAL = <<-POST
.post
  .title= link_to post.title, url_for(:posts, :show, :id => post)
  .date= time_ago_in_words(post.created_at || Time.now) + ' ago'
  .body= simple_format(post.body)
  .details
    .author Posted by \#{post.account.email}
POST
create_file 'app/views/posts/_post.haml', POST_PARTIAL

# Create show.haml
POST_SHOW = <<-POST
- @title = @post.title
#show
  .post
    .title= @post.title
    .date= time_ago_in_words(@post.created_at || Time.now) + ' ago'
    .body= simple_format(@post.body)
    .details
      .author Posted by \#{@post.account.email}
%p= link_to 'View all posts', url_for(:posts, :index)
POST
create_file 'app/views/posts/show.haml', POST_SHOW

APPLICATION = <<-LAYOUT
!!! Strict
%html
  %head
    %title= [@title, "Padrino Sample Blog"].compact.join(" | ")
    = stylesheet_link_tag 'reset', 'application'
    = javascript_include_tag 'jquery', 'application'
    = yield_content :include
  %body
    #header
      %h1 Sample Padrino Blog
      %ul.menu
        %li= link_to 'Blog', url_for(:posts, :index)
        %li= link_to 'About', url_for(:about)
    #container
      #main= yield
      #sidebar
        - form_tag url_for(:posts, :index), :method => 'get'  do
          Search for:
          = text_field_tag 'query', :value => params[:query]
          = submit_tag 'Search'
        %p Recent Posts
        %ul.bulleted
          %li Item 1 - Lorem ipsum dolorum itsum estem
          %li Item 2 - Lorem ipsum dolorum itsum estem
          %li Item 3 - Lorem ipsum dolorum itsum estem
        %p Categories
        %ul.bulleted
          %li Item 1 - Lorem ipsum dolorum itsum estem
          %li Item 2 - Lorem ipsum dolorum itsum estem
          %li Item 3 - Lorem ipsum dolorum itsum estem
        %p Latest Comments
        %ul.bulleted
          %li Item 1 - Lorem ipsum dolorum itsum estem
          %li Item 2 - Lorem ipsum dolorum itsum estem
          %li Item 3 - Lorem ipsum dolorum itsum estem
    #footer
      Copyright (c) 2009-2010 Padrino
LAYOUT
create_file 'app/views/layouts/application.haml', APPLICATION

get 'https://github.com/padrino/sample_blog/raw/master/public/stylesheets/reset.css', 'public/stylesheets/reset.css'
get "https://github.com/padrino/sample_blog/raw/master/app/stylesheets/application.sass", 'app/stylesheets/application.sass'
