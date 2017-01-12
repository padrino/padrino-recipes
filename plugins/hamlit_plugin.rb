##
# Use hamlit instead of haml for rendering
# This is basically a copy of the existing integration for slim

RENDERING=<<'RUBY'
module Padrino
  module Helpers
    module OutputHelpers
      ##
      # Handler for Hamlit templates.
      #
      class HamlitHandler < AbstractHandler
        ##
        # Returns true if the block is for Hamlit.
        #
        def engine_matches?(block)
          block.binding.eval('defined? __in_hamlit_template')
        end
      end
      OutputHelpers.register(:haml, HamlitHandler)
    end
  end
end

module Padrino
  module Rendering
    class HamlitOutputBuffer < Temple::Generators::StringBuffer
      define_options :buffer_class => 'SafeBuffer'

      def call(exp)
        [preamble, compile(exp), postamble].flatten.compact.join('; '.freeze)
      end

      def create_buffer
        "#{buffer} = #{options[:buffer_class]}.new"
      end

      def concat(str)
        "#{buffer}.safe_concat((#{str}))"
      end
    end

    class HamlitTemplate < Hamlit::Template
      include SafeTemplate

      def precompiled_preamble(locals)
        "__in_hamlit_template = true\n" << super
      end
    end
  end
end

Tilt.prefer(Padrino::Rendering::HamlitTemplate, :haml)

Padrino::Rendering.engine_configurations[:haml] = {
  :generator => Padrino::Rendering::HamlitOutputBuffer,
  :buffer => "@_out_buf",
  :use_html_safe => true,
}
RUBY

create_file destination_root('lib/padrino-hamlit.rb'), RENDERING
require_dependencies 'hamlit'

say "Unless you need haml, you can remove it from your Gemfile."
