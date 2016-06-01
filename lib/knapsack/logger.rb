module Knapsack
  class Logger
    attr_accessor :level

    DEBUG = 0
    INFO = 1
    WARN = 2

    UnknownLogLevel = Class.new(StandardError)

    def log(level, text=nil)
      level_method =
        case level
        when DEBUG then :debug
        when INFO then :info
        when WARN then :warn
        else raise UnknownLogLevel
        end

      public_send(level_method, text)
    end

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
