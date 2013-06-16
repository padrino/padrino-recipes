# Template for an AngularJS app. It uses bower to manage your frontend resources.
opts = options.dup
opts.delete :template
project opts.merge(renderer: :slim)
#, stylesheet: :scss, orm: :sequel, adapter: :postgres 

# Default routes
APP_INIT = <<-APP
  get :index do
    @title = 'Index'
    @ng_app = "app"

    render :index
  end
APP
inject_into_file 'app/app.rb', APP_INIT, before: "#\n  end\n"

# App server 
inject_into_file 'Gemfile', "gem 'puma'", after: "# Server requirements\n"


# Create index.slim
INDEX = <<-INDEX
h1 Numbers
ol ng-controller="MyController"
  li ng-repeat="number in numbers" I'm {{ number }} :)

- content_for :head do
  -#= stylesheet_link_tag :app

- content_for :body do
  = javascript_include_tag :'/components/angular/angular.min', :app, defer: true 
INDEX
create_file 'app/views/index.slim', INDEX

APPLICATION = <<-LAYOUT
doctype html
html
  head
    meta[charset="utf-8"]
    meta[http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"]
    title = @title 
    meta[name="viewport" content="width=device-width, initial-scale=1.0"]
    meta[name="author" content=""]
    meta[name="description" content=""]
    = stylesheet_link_tag '/components/normalize-css/normalize', :app
    = yield_content :head
  body ng-app="\#{@ng_app}"
    = yield
    = yield_content :body
LAYOUT
create_file 'app/views/layouts/application.slim', APPLICATION

# Create app.js 
APP = <<-APP
!function() {
  var app = angular.module('app', []);

  app.controller('MyController', function($scope) {
    $scope.numbers = [1,2,3,4,5];
  });
}(window);
APP
create_file 'public/javascripts/app.js', APP

# Create NPM's package.json
PACKAGE = <<-PACKAGE
{
  "name": "app",
  "version": "0.0.1",
  "dependencies": {
    "bower": "*"
  }
}
PACKAGE
create_file 'public/package.json', PACKAGE 

# Create bower.json
BOWER = <<-BOWER
{
  "name": "app",
  "version": "0.0.1",
  "dependencies": {
    "normalize-css": "latest",
    "angular": "PatternConsulting/bower-angular"
  }
}
BOWER
create_file 'public/bower.json', BOWER

# Ignore npm/bower specific stuff 
IGNORE = <<-IGNORE
public/node_modules
public/components/**/*.*
!public/components/**/*[.|-]min.*
# Custom ignore excludes for libs that don't follow the .min or -min convention 
!public/components/normalize-css/normalize.css
IGNORE
append_file '.gitignore', IGNORE

# TODO Fix. For some reason npm install --dev fails here if I only set devDependencies in package.json
system "cd #{destination_root}/public && npm install"
system "cd #{destination_root}/public && ./node_modules/bower/bin/bower install --save"
