# Payment(ActiveMerchant Wrapper) plugin on Padrino
# prereqs:
# sudo gem install rack-payment
# http://github.com/devfu/rack-payment
PAYMENT = <<-PAYMENT
    require 'rack/payment'
    app.use Rack::Payment, 
      :gateway   => 'paypal', 
      :login     => 'bob', 
      :password  => 'secret', 
      :signature => '123abc', 
      :test_mode => true # during real usage, set this to false
    app.helpers Rack::Payment::Methods
PAYMENT
require_dependencies 'rack-payment'
initializer :payment,PAYMENT