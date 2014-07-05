module Knapsack
  class Report
    REPORT_PATH = 'knapsack_report.json'

    class << self
      def save(report_path=nil)
        File.open(report_path || REPORT_PATH, 'w+') do |f|
          f.write(Presenter.report_json)
        end
      end

      def open(report_path=nil)
        report = File.read(report_path || REPORT_PATH)
        JSON.parse(report)
      rescue Errno::ENOENT
        raise "Knapsack report file doesn't exist. Please generate report first!"
      end
    end
  end
end
