## Preface

Padrino is a Ruby framework built upon the excellent [Sinatra Microframework](http://www.sinatrarb.com). Sinatra is a
DSL for creating simple web applications in Ruby with speed and minimal effort. This framework tries hard to make it as
fun and easy as possible to code much more advanced web applications by building upon the Sinatra philosophies and
foundation.


The recipes consists of two types: *plugins* and *templates*. A plugin adds additional functionality to an existing
Padrino project. A template can be used as a template for a completely new Padrino application.


To run a template,


    $ padrino-gen project my_project --template [template_path]


The templates are separated into two types:


### Plugins

To run plugin,


    $ cd <path-to-my-padrino-app>
    $ padrino-gen plugin <name-of-the-plugin>


- 960                - 960.gs grid
- access             - Access restriction via rack-contrib.
- ar\_permalink       - Generate permalink for a specified column on ActiveRecord.
- ar\_permalink\_i18n  - Generate permalink for a specified multi language column(s) on ActiveRecord.
- ar\_textile         - Full support to textile with ActiveRecord.
- ar\_translate       - Translate for you your ActiveRecord columns.
- auto\_locale        - Switch for you automatically the I18n.locale.
- barista            - Add support for Coffeescript via Barista.
- better\_error       - Add support for the `better_error` Gem.
- blueprint          - Blueprint CSS.
- bootstrap          - Add Twitter bootstrap CSS.
- bug                - rack-bug plugin.
- carrierwave        - Carrierwave plugin via carrierwave.
- codehighlighter    - Code Highlighting via rack-codehighlighter.
- coderay            - Code Highlighting via rack-coderay.
- coffee             - CoffeeScript plugin via rack-coffee.
- deflect            - Deflect(DOS protection) via rack-contrib.
- disqus             - Disqus Commenting System via disqus gem.
- dreamhost          - Deploy your app on DreamHost.com.
- exception\_notifier - Send errors through mail or/and to redmine.
- flash\_session      - Middleware that help you in passing your session in the URI, when it should be in the cookie.
- googleanalytics    - Google Analytics via rack-google-analytic.
- heroku             - Prepare app for deployment to Heroku (thanks to commuter).
- hoptoad            - HopToad notification via rack\_hoptoad.
- jammit             - Add Asset Packaging via jammit-sinatra (thanks to railsjedi).
- maintenance        - Maintenance page plugin via rack-maintenance.
- omniauth           - Authentication Plugin for OAuth2, Facebook, Twitter, Campfire via omniauth.
- openid             - OpenID authentication via rack-openid.
- payment            - Payment Plugin via rack-payment.
- protection         - Add support rack-protection to your app to protect against certain security exploitations.
- recaptcha          - CAPTCHA verification using RECAPTCHA API via rack-recaptcha.
- resque             - Add support for the resque redis based background worker.
- rewrite            - Rewrite Rules via rack-rewrite.
- secure\_only        - Run app on https via rack-secure\_only (thanks to splir).
- tripoli            - Tripoli CSS.
- twitter-login      - Twitter Login Authentication via twitter-login.
- vcr                - Add VCR to your test suite.
- watchr             - Generates watchr test scripts.
- will\_paginate     - Add support for will\_paginate.


If you want to contribute with a plugin please follow the convention of having `_plugin` appended to the name (i.e.
`bootstrap_plugin.rb`).


### Templates

The templates folder contains full project generation templates. These files follow the convention of having *\_template*
appended to the name. (i.e **sampleblog_template.rb**) Included template are:


- sampleblog - [sample blog tutorial](http://www.padrinorb.com/guides/blog-tutorial)
- lipsiasoft - template with haml/960/exception notifier and more used by [LipsiaSOFT](http://www.lipsiasoft.com)
- mongochist - templates that generate mongoid/mongomapper with machinist


## Contribute

Feel free to fork and add on to these recipes! Check out the [Padrino Framework](http://www.padrinorb.com) and its
[git repo](http://github.com/padrino/padrino-framework).
