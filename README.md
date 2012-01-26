# Padrino-Recipes
#

Padrino is the godfather of Sinatra. These are some of his recipes.

## Preface

Padrino is a ruby framework built upon the excellent [Sinatra Microframework](http://www.sinatrarb.com).
Sinatra is a DSL for creating simple web applications in Ruby with speed and minimal effort.
This framework tries hard to make it as fun and easy as possible to code much more advanced web applications by
building upon the Sinatra philosophies and foundation.

The templates here work with the templates fork of padrino-framework. To run them:

To run plugin,

    my_project $ padrino-gen plugin [template_path]

To run a template,

    $ padrino-gen project my_project --template [template_path]

The templates are seperated into two types:

### Plugins

The plugin folders contains templates that can be ran to *plugin* certain libraries into the padrino application. These file follow the convention of having *_plugin* appended to the name.(i.e **coderay_plugin.rb**) Currently included are:

*   coderay            - Code Highlighting via rack-coderay
*   hoptoad            - HopToad notification via rack_hoptoad
*   maintenance        - Maintenance page plugin via rack-maintenance
*   openid             - OpenID authentication via rack-openid
*   fluxflex           - Deploy your app on FluxFlex.com PaaS
*   carrierwave        - Carrierwave plugin via carrierwave
*   twitter-login      - Twitter Login Authentication via twitter-login
*   payment            - Payment Plugin via rack-payment
*   blueprint          - Blueprint CSS
*   tripoli            - Tripoli CSS
*   access             - Access Restriction via rack-contrib
*   deflect            - Deflect(DOS protection) via rack-contrib
*   recaptcha          - CAPTCHA verification using RECAPTCHA API via rack-recaptcha
*   googleanalytics    - Google Analytics via rack-google-analytic
*   disqus             - Disqus Commenting System via disqus gem
*   rewrite            - Rewrite Rules via rack-rewrite
*   codehighlighter    - Code Highlighting via rack-codehighlighter
*   coffee             - CoffeeScript plugin via rack-coffee
*   bug                - rack-bug plugin
*   omniauth           - Authentication Plugin for OAuth2, Facebook, Twitter, Campfire via omniauth
*   exception_notifier - Send errors through mail or/and to redmine
*   960                - 960.gs grid
*   ar_permalink       - Generate permalink for a specified column on ActiveRecord
*   ar_permalink_multi - Generate permalink for a specified multi language column(s) on ActiveRecord
*   ar_translate       - Translate for you your ActiveRecord columns
*   auto_locale        - Switch for you automatically the I18n.locale
*   flash_session      - Middleware that help you in passing your session in the URI, when it should be in the cookie.
*   ar_textile         - Full support to textile with ActiveRecord
*   watchr             - generates watchr test scripts
*   heroku             - Prepare app for deployment to Heroku ( Thanks to commuter )
*   secure_only        - Run app on https via rack-secure\_only ( Thanks to splir )
*   jammit             - Add Asset Packaging via jammit-sinatra ( Thanks to railsjedi )
*   resque             - Add support for the resque redis based background worker
*   barista            - Add support for Coffeescript via Barista
*   protection         - Add support rack-protection to your app to protect against certain security exploitations
*   will\_paginate     - Add support for will\_paginate
*   bootstrap          - Add Twitter bootstrap
*   vcr                - Add VCR to your test suite.
*   dreamhost          - Deploy your app on DreamHost.com

### Templates

The templates folder contains full project generation templates. These files follow the convention of having *_template* appended to the name. (i.e __sampleblog_template.rb__) Included template are:

  *   sampleblog - [sample blog tutorial](http://www.padrinorb.com/guides/blog-tutorial)
  *   lipsiasoft - template with haml/960/exception notifier and more used by [LipsiaSOFT](http://www.lipsiasoft.com)
  *   mongochist - templates that generate mongoid/mongomapper with machinist

## Contribute

Feel free to fork and add on to these recipes!
check out the [Padrino Framework](http://www.padrinorb.com) and its [git repo](http://github.com/padrino/padrino-framework)
