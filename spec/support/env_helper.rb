module EnvHelper
  def with_env(vars)
    original = ENV.to_hash
    vars.each { |k, v| ENV[k] = v }

    begin
      yield
    ensure
      ENV.replace(original)
    end
  end
end
RSpec.configuration.include EnvHelper
