##
# Barista Plugin on Padrino
# prereqs:
#
# gem install barista
#
COFFEE = <<-COFFEE
module BaristaInitializer

  def self.registered(app)
    # Find more options for Barista at:
    # https://github.com/Sutto/barista
    #
    Barista.configure do |c|

      # Change the root to use app/scripts
      #
      c.root = File.join(Padrino.root, "assets", "javascripts")

      # Change the output root, causing Barista to compile into public/coffeescripts
      #
      # c.output_root = Rails.root.join("public", "coffeescripts")

      # Change the output root for a framework:
      #
      # c.change_output_prefix! 'framework-name', 'output-prefix'

      # Or change the prefix for all frameworks, use #each_framework:
      #
      # c.each_framework do |framework|
      #   c.change_output_prefix! framework.name, "vendor/\#{framework.name}"
      # end


      # Or, hook into the compilation:
      #
      # c.before_compilation          { |path|         puts "Barista: Compiling \#{path}" }
      # c.on_compilation              { |path|         puts "Barista: Successfully compiled \#{path}" }
      # c.on_compilation_error        { |path, output| puts "Barista: Compilation of \#{path} failed with:\n\#{output}" }
      # c.on_compilation_with_warning { |path, output| puts "Barista: Compilation of \#{path} had a warning:\n\#{output}" }
    end

    app.register Barista::Integration::Sinatra
  end
end
COFFEE

APP_INIT = <<-INIT
  configure :development do
    register BaristaInitializer
  end
INIT

create_file destination_root('lib/barista_init.rb'), COFFEE
inject_into_file destination_root('app/app.rb'), APP_INIT, :after => "enable :sessions\n"
require_dependencies 'barista', :group => :development
