# Template to get Rewrite on Padrino
# prereqs:
# sudo gem install rack-rewrite
# http://github.com/jtrupiano/rack-rewrite
# View the github readme for additional rewrite rules
REWRITE = <<-REWRITE
    app.use Rack::Rewrite do
        # rewrite '/wiki/John_Trupiano', '/john'
        # r301 '/wiki/Yair_Flicker', '/yair'
        # r302 '/wiki/Greg_Jastrab', '/greg'
        # r301 %r{/wiki/(\w+)_\w+}, '/$1'
      end
REWRITE
require_dependencies 'rack-rewrite'
initializer :rewrite,REWRITE