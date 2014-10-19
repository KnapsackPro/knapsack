module Knapsack
  class Report
    include Singleton

    def config(args={})
      @config ||= args
      @config.merge!(args)
    end

    def report_path
      config[:report_path] || raise('Missing report_path')
    end

    def spec_pattern
      config[:spec_pattern] || raise('Missing spec_pattern')
    end

    def save
      File.open(report_path, 'w+') do |f|
        f.write(report_json)
      end
    end

    def open
      report = File.read(report_path)
      JSON.parse(report)
    rescue Errno::ENOENT
      raise "Knapsack report file doesn't exist. Please generate report first!"
    end

    private

    def report_json
      Presenter.report_json
    end
  end
end
