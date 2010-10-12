##
# Twitter Login plugin on Padrino
#
# prereqs:
# sudo gem install twitter-login
# http://github.com/mislav/twitter-login
#
TWITTER = <<-TWITTER
    app.use Twitter::Login,
      :consumer_key => 'KEY',
      :secret => 'SECRET'
      # :login_path => '/login',
      # :return_to => '/'
    app.helpers Twitter::Login::Helpers
TWITTER
require_dependencies 'twitter-login', :require => 'twitter/login', :version => "= 0.3"
initializer :twitter_login, TWITTER
inject_into_file destination_root('app/app.rb'),"    enable :sessions\n", :after => "configure do\n"
