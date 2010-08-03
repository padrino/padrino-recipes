##
# Inserts Blueprint CSS into your project.
# prereqs:
# include the generated partial into your layout!
#
ERB = <<-ERB
<%= stylesheet_link_tag 'tripoli' %>
<%= stylesheet_link_tag 'simple' %>
ERB
type = fetch_component_choice(:renderer)
create_file destination_root("app/views/shared/_tripoli.#{type}"), (type == 'erb' ? ERB : ERB.gsub(/(<%)|(%>)/,''))
get "http://devkick.com/lab/tripoli/tripoli.simple.css", destination_root('public/stylesheets/simple.css')
get "http://devkick.com/lab/tripoli/tripoli.base.css", destination_root('public/stylesheets/tripoli.css')
say "Now, include the generated partial app/views/shared/_tripoli.#{type} into your layout!", :green