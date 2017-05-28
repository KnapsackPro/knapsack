class Time
  class << self
    # The alias method .now_without_mock is different than in Timecop gem (timecop uses .now_without_mock_time)
    # to ensure there will be no conflict
    alias_method :raw_now, :now
  end
end
