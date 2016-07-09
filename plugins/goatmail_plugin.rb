##
# Goatmail plugin on Padrino
#
# https://github.com/tyabe/goatmail
#
# You can view all send mail under the /inbox URL in development mode

GEMFILE = <<-GEMFILE
group :development do
  gem 'goatmail'
end

GEMFILE
append_file("Gemfile", GEMFILE)

CONFIG = <<-CONFIG
if Padrino.env == :development
  Padrino.configure_apps do
    set :delivery_method, Goatmail::DeliveryMethod => {}
  end

  Padrino.mount('Goatmail::App').to('/inbox')
end

CONFIG

inject_into_file destination_root('config/apps.rb'), CONFIG, :after  => "end\n\n"
