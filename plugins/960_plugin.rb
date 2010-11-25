%w(reset text 960).each do |file|
  get "https://github.com/nathansmith/960-Grid-System/raw/master/code/css/#{file}.css", "public/stylesheets/#{file}.css"
end

%w(12 16 24).each do |file|
  get "https://github.com/nathansmith/960-Grid-System/raw/master/code/img/#{file}_col.gif", "public/images/#{file}_col.gif"
end

say "Now add: reset.css, text.css, 960.css in your layout!", :green