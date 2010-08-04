##
# This extension give to padrino the ability to change
# their locale inspecting.
#
# ==== Usage
#
#   class MyApp < Padrino::Application
#     register AutoLocale
#     set :locales, [:en, :ru, :de] # First locale is the default locale
#   end
#
# So when we call an url like: /ru/blog/posts this extension set for you :ru as I18n.locale
#
# prereqs:
# sudo gem install padrino-contrib
#
require_contrib('auto_locale')
initializer("Padrino::Contrib::AutoLocale")
inject_into_file "app/app.rb", "  # set :locales, [:en, :ru, :de] # First locale is the default locale\n", :after => "Padrino::Contrib::AutoLocale\n"