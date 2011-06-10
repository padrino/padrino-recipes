##
# Template to get Disqus on Padrino
# prereqs:
# sudo gem install disqus
# http://github.com/norman/disqus
# NOTE:
# please see the readme of disqus for additional setup info.
#
DISQUS = <<-DISQUS
    # Configure it
    #
    #   Disqus::defaults[:account] = "my_disqus_account"
    #
    # Optional, only if you're using the API Disqus::defaults[:api_key] = "my_disqus_api_key"
    #
    # Show the comment threads widget on a post page
    #
    # Loads the commenting system
    #   disqus_thread
    #
    #   # Sets the inner html to the comment count for any links on the page that
    #   # have the anchor "disqus_thread". For example, "View Comments" below would
    #   # be replaced by "1 comment" or "23 comments" etc.
    #   # <a href="http://my.website/article-permalink#disqus_thread">View Comments</a>
    #   # <a href="http://my.website/different-permalink#disqus_thread">View Comments</a>
    #   disqus_comment_counts
    #
    # Show the combo widget on a post page
    #
    #   disqus_combo(:color => "blue", :hide_mods => false, :num_items => 20)
    #
    # Show the comment count on a permalink
    #
    #   link_to("Permalink", url(:posts, :id => @post, :anchor => "disqus_thread"))
    #   disqus_comment_counts
    #
    Disqus.defaults.update({
      :api_key         => "",                          # your api key
      :account         => "",                          # your disqus account
      :developer       => Padrino.env == :development, # allows threads to work on localhost
      :container_id    => 'disqus_thread',             # desired thread container
      :avatar_size     => 48,                          # squared pixel size of avatars
      :color           => "grey",                      # theme color: ["blue", "grey", "green", "red", "orange"]
      :default_tab     => "popular",                   # default widget tab
      :hide_avatars    => false,                       # hide or show avatars
      :hide_mods       => true,                        # hide or show moderation
      :num_items       => 15,                          # number of comments to display
      :show_powered_by => true,                        # show or hide powered by line
      :orientation     => "horizontal"                 # comment orientation
    })
DISQUS
require_dependencies 'disqus'
initializer :disqus, DISQUS