# Template to get Recaptcha on Padrino
# prereqs:
# sudo gem install rack-recaptcha
# http://github.com/achiu/rack-recaptcha
RECAPTCHA = <<-RECAPTCHA
    app.use Rack::Recaptcha,
      :private_key => "YOUR_PRIVATE_KEY",
      :public_key => "YOUR_PUBLIC_KEY", 
      :login_path => "YOUR_LOGIN_PATH"
    app.helpers Rack::Recaptcha::Helpers
RECAPTCHA
require_dependencies 'rack-recaptcha', :require => 'rack/recaptcha'
initializer :recatpcha,RECAPTCHA