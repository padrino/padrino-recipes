##
# This module extend ActiveRecord.
#
# You need to add to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page, :langs => [:en, :fr, :de]
#   end
#
AR_PERMALINK_MULTI = <<-RUBY
##
# This module extend ActiveRecord.
#
# You need to to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page, :langs => [:en, :fr, :de]
#   end
#
module Permalink
  module ClassMethods
    def has_permalink(field, options={})
      include InstanceMethods
      class_inheritable_accessor  :permalink_field, :permalink_langs
      write_inheritable_attribute :permalink_field, field
      write_inheritable_attribute :permalink_langs, options.delete(:langs)
      before_save :generate_permalinks
      permalink_langs.each do |lang|
        validates_uniqueness_of :"#{field}_#{lang}", options
      end
    end

    def permalink_for(name)
      name = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', name).to_s
      name.gsub!(/\W+/, ' ') # non-words to space
      name.strip!
      name.downcase!
      name.gsub!(/\s+/, '-') # all spaces to dashes
      name
    end
  end

  module InstanceMethods
    def to_param
      permalink
    end

    protected
      def generate_permalinks
        permalink_langs.each do |lang|
          self.send(:"permalink_#{lang}=", self.class.permalink_for(read_attribute(:"#{permalink_field}_#{lang}")))
        end
      end
  end # InstanceMethods
end # Permalink
ActiveRecord::Base.extend(Permalink::ClassMethods)
RUBY
create_file "lib/permalink", AR_PERMALINK_MULTI