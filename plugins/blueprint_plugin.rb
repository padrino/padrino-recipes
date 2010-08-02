# Inserts Blueprint CSS into your project.
# prereqs:
# include the generated partial into your layout!
ERB = <<-ERB
<%= stylesheet_link_tag 'screen', :media => 'screen,projection' %>
<%= stylesheet_link_tag 'print',  :media => 'print' %>
ERB
type = fetch_component_choice(:renderer)
path = "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/"
create_file destination_root("app/views/shared/_blueprint.#{type}"), (type == 'erb' ? ERB : ERB.gsub(/(<%)|(%>)/,''))
get (path + "screen.css"), destination_root('public/stylesheets/screen.css')
get (path + "print.css"), destination_root('public/stylesheets/print.css')
say "Now, include the generated partial app/views/shared/_blueprint.#{type} into your layout!", :green