require 'time'

class Time
  class << self
    alias_method :raw_now, :now
  end
end
