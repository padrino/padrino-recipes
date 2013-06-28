##
# Letter Opener plugin on Padrino
#
# https://github.com/ryanb/letter_opener
#

GEMFILE = <<-GEMFILE

# Letter Opener
gem 'letter_opener', :group => 'development'
GEMFILE
append_file "Gemfile", GEMFILE

CONFIG = <<-CONFIG
  # Setup letter_opener
  if Padrino.env == :development
    set :delivery_method, {
      LetterOpener::DeliveryMethod => {
        location: Padrino.root('tmp/letter_opener')
      }
    }
  end
CONFIG
inject_into_file destination_root('config/apps.rb'), CONFIG, :after => "Padrino.configure_apps do\n"
