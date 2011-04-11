ASSETS_YML = <<-ASSETS_YML
package_assets: on
package_path: assets-compiled
compress_assets: true
javascript_compressor: closure
gzip_assets: true

javascripts:
  application:
    - public/javascripts/application.js
    - public/javascripts/libraries/**/*.js
    - public/javascripts/templates/**/*.jst

stylesheets:
  application:
    - public/stylesheets/**/*.css
ASSETS_YML

JAMMIT_REGISTER = (<<-JAMMITR).gsub(/^ {10}/, '') unless defined?(JAMMIT_REGISTER)
  register Jammit\n
JAMMITR

JAMMIT_HOOK = (<<-JAMMITH).gsub(/^ {2}/, '') unless defined?(JAMMIT_HOOK)
  Padrino.after_load do
    ::RAILS_ENV = PADRINO_ENV unless defined?(::RAILS_ENV) # jammit 0.6.0 workaround
    Jammit.load_configuration("\#{Padrino.root}/config/assets.yml")
  end

JAMMITH

require_dependencies 'jammit-sinatra'

create_file "config/assets.yml", ASSETS_YML

inject_into_file destination_root('/app/app.rb'), JAMMIT_REGISTER, :after => "register Padrino::Helpers\n"

inject_into_file destination_root('config/boot.rb'), JAMMIT_HOOK, :before => "Padrino.load!"