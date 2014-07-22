module Knapsack
  class Logger
    attr_accessor :level

    DEBUG = 0
    INFO = 1
    WARN = 2

    def debug(text=nil)
      return if level != DEBUG
      puts text
    end

    def info(text=nil)
      return if level > INFO
      puts text
    end

    def warn(text=nil)
      return if level > WARN
      puts text
    end
  end
end
