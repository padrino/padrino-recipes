##
# This module extend ActiveRecord.
#
# You need to to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page
#   end
#
AR_PERMALINK <<-RUBY
##
# This module extend ActiveRecord.
#
# You need to to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page
#   end
#
module ArPermalink

  module ClassMethods

    def has_permalink(field)
      include InstanceMethods
      class_inheritable_accessor  :permalink_field
      write_inheritable_attribute :permalink_field, field
      before_save :generate_permalink
    end
  end # ClassMethods

  module InstanceMethods

    def to_param
      permalink
    end

    protected
      def generate_permalink
        self.permalink = read_attribute(permalink_field).downcase.
                                                         gsub(/\\W/, '-').
                                                         gsub(/-+/, '-').
                                                         gsub(/-$/, '').
                                                         gsub(/^-/, '')
      end
  end # InstanceMethods
end # ArPermalink
ActiveRecord::Base.extend(Permalink::ClassMethods)
RUBY
create_file "lib/permalink", AR_PERMALINK