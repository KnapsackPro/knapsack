# https://github.com/cucumber/cucumber/blob/master/lib/cucumber/rb_support/rb_dsl.rb
module Cucumber
  module RbSupport
    class RbDsl
      class << self
        def register_rb_hook(phase, tag_names, proc)
          proc.call
        end
      end
    end
  end
end
