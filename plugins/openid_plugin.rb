# Template for OpenID on Padrino
# prereqs:
# sudo gem install rack-openid
# http://github.com/josh/rack-openid
OPENID = <<-OPENID
    require 'rack/openid'
    app.use Rack::Session::Cookie
    app.use Rack::OpenID
OPENID
POST = <<-POST
    if resp = request.env["rack.openid.response"]
      if resp.status == :success
        "Welcome: \#{resp.display_identifier}"
      else
        "Error: \#{resp.status}"
      end
    else
      headers 'WWW-Authenticate' => Rack::OpenID.build_header(:identifier => params["openid_identifier"])
      throw :halt, [401, 'got openid?']
    end
POST
FORM = <<-FORM
<% form_tag '/openid/login', :method => 'post' do %>
  <p>
  <%= label_tag :openid_identifier %>
  <%= text_field_tag :openid_identifier %>
  </p>
  <p>
    <%= submit_tag 'Sign In' %>
  </p>
<% end %>
FORM
require_dependencies 'rack-openid'
initializer :openid,OPENID
generate :controller, "openid get:login post:login"
inject_into_file destination_root('app/controllers/openid.rb'), "   render 'openid/login'\n", :after => "get :login do\n"
inject_into_file destination_root('app/controllers/openid.rb'), POST, :after => "post :login do\n"
create_file destination_root('app/views/openid/login.erb'),FORM