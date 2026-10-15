# Preface

Padrino is a Ruby framework built upon the excellent [Sinatra Microframework](http://www.sinatrarb.com). Sinatra is a
DSL for creating simple web applications in Ruby with speed and minimal effort. This framework tries hard to make it as
fun and easy as possible to code much more advanced web applications by building upon the Sinatra philosophies and
foundation.


The recipes consists of two types: *plugins* and *templates*. A plugin adds additional functionality to an existing
Padrino project. A template can be used as a template for a completely new Padrino application.


## Plugins

To run a plugin:

```sh
$ cd <path-to-my-padrino-app>
$ padrino-gen plugin <name-of-the-plugin>
```


- 960: Installs the [960 grid system](https://github.com/nathansmith/960-Grid-System)
- access: Access Plugin via [rack-contrib](http://github.com/rack/rack-contrib/)
- ar\_permalink: Generate permalink for a specified column on ActiveRecord.
- ar\_permalink\_i18n: Generate permalink for a specified multi language column(s) on ActiveRecord.
- ar\_textile: Full support to textile with ActiveRecord.
- ar\_translate: Translate for you your ActiveRecord columns.
- auto\_locale: Switch the I18n.locale automatically based on the URL.
- barista: Simple, transparent [CoffeeScript](https://github.com/jashkenas/coffeescript) support.
- bulma: [bulma](https://bulma.io "bulma") is an open source CSS framework based on Flexbox.
- better\_errors: Install the [better_errors gem](https://github.com/charliesome/better_errors).
- bootstrap: Install the latest [twitter bootstrap](https://github.com/twbs/bootstrap) files.
- bug: (rack-bug)[http://github.com/brynary/rack-bug] debugging toolbar for Rack applications.
- camorra: Install (ZURB Foundation 5 framework)[http://foundation.zurb.com/].
- carrierwave: Plugin for [Carrierwave](https://github.com/carrierwaveuploader/carrierwave).
- codehighlighter: Code highlighting via [rack-codehighlighter](https://github.com/wbzyl/rack-codehighlighter)
- deflect: Deflect (DOS protection) via [rack-contrib](http://github.com/rack/rack-contrib/).
- disqus: [Disqus](https://disqus.com/) commenting system via [disqus gem](https://github.com/norman/disqus).
- dreamhost: Deploy your app on [DreamHost](https://www.dreamhost.com/).
- exception\_notifier: Send errors through mail or/and to [redmine](http://www.redmine.org/) via [exception_notifier](https://github.com/padrino/padrino-contrib/blob/master/lib/padrino-contrib/exception_notifier.rb).
- factory\_bot: A [library](https://github.com/thoughtbot/factory_bot) for setting up Ruby objects as test data.
- fontawesome: Installing [Font Awesome 4.7](https://github.com/FortAwesome/Font-Awesome/tree/v4.7.0).
- goatmail: Preview mail in the browser under `/inbox` in development mode with [goatmail](https://github.com/tyabe/goatmail).
- heroku: Prepare app for deployment to [Heroku](https://heroku.com/).
- letter_opener: Preview mail in the browser instead of sending vim with [letter_opener](https://github.com/ryanb/letter_opener).
- omniauth: Authentication Plugin for OAuth2, Facebook, Twitter, Campfire via [omniauth](https://github.com/intridea/omniauth/).
- payment: Payment Plugin via [rack-payment](https://rubygems.org/gems/rack-payment/versions/0.1.4)
- pry\_byebug: Use [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) in Padrino. Use pry_debugger plugin for MRI 1.9.3 or older.
- pry\_debugger: Use [pry-debugger](https://github.com/nixme/pry-debugger) in Padrino. Use pry_byebug plugin for MRI 2.0.0 or newer.
- raphaeljs: Add [RaphaelJS](https://github.com/DmitryBaranovskiy/raphael) libraries.
- raphy\_charts: [Raphy Charts](https://github.com/jcarver989/raphy-charts) - a RaphaelJS based HTML5/SVG charts library.
- resque: Add support for the [resque](https://github.com/resque/resque) redis based background worker.
- rewrite: Rewrite Rules via [rack-rewrite](https://github.com/jtrupiano/rack-rewrite).
- secure\_only: Run app on https via [rack-secure_only](https://github.com/spllr/rack-secure_only).
- vcr: Add [vcr](https://github.com/vcr/vcr) to your test suite.
- will\_paginate: Add support for [will_paginate](https://github.com/mislav/will_paginate).
- react-sinatra: Add support for [react-sinatra](https://github.com/namusyaka/react-sinatra).


If you want to contribute with a plugin please follow the convention of having `_plugin` appended to the name (i.e.
`bootstrap_plugin.rb`). Don't forget to put your plugin with a short explanation to the README here.


## Templates

To run a template:

```sh
$ padrino-gen project my_project --template [template_path]
```

The [templates folder](https://github.com/padrino/padrino-recipes/tree/master/templates) contains full project generation templates.
These files follow the convention of having *_template*
appended to the name (i.e **sampleblog_template.rb**). Included template are:


- mongochist: templates that generate mongoid/mongomapper with machinist.
- sampleblog: [sample blog tutorial](http://padrinorb.com/guides/getting-started/blog-tutorial).


## Contribute

Feel free to fork and add on to these recipes! Check out the [Padrino Framework](http://www.padrinorb.com) and its
[git repo](http://github.com/padrino/padrino-framework).
