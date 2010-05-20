# Template to get Recaptcha on Padrino
# prereqs:
# sudo gem install rack-recaptcha
# http://github.com/achiu/rack-recaptcha
# NOTE:
# if you have another sub app in the application, you must register in the apps app.rb
RECAPTCHA = <<-RECAPTCHA
    app.use Rack::Recaptcha,
      :private_key => "YOUR_PRIVATE_KEY",
      :public_key => "YOUR_PUBLIC_KEY", 
      :paths => "YOUR_LOGIN_PATH(S)"
    app.helpers Rack::Recaptcha::Helpers
RECAPTCHA
require_dependencies 'rack-recaptcha', :require => 'rack/recaptcha'
initializer :recatpcha,RECAPTCHA