## 
# React Ingegration for Padrino
# @see https://github.com/namusyaka/react-sinatra
# 
REACT_SINATRA_INIT = <<-REACT
  configure do
    React::Sinatra.configure do |config|
      config.use_bundled_react = true
      config.env          =  ENV['RACK_ENV'] || ENV['PADRINO_ENV']
      config.runtime      = :execjs
      # Your javascript for server site should be placed in {Padrino.root}client/dist/server.js
      config.asset_path   = %w(client/dist/server.js)
      config.pool_size    = 5
      config.pool_timeout = 10
    end
  
    React::Sinatra::Pool.pool.reset
  end
REACT

require_dependencies 'react-sinatra'
require_dependencies 'execjs'
require_dependencies 'mini_racer'

inject_into_file destination_root('app/app.rb'), REACT_SINATRA_INIT, :after => "enable :sessions\n"
