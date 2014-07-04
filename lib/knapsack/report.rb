module Knapsack
  class Report
    REPORT_PATH = 'knapsack_report.json'

    class << self
      def save
        File.open(REPORT_PATH, 'w+') do |f|
          f.write(Presenter.report_json)
        end
      end

      def open
        report = File.read(REPORT_PATH)
        JSON.parse(report)
      rescue Errno::ENOENT
        raise "Knapsack report file doesn't exist. Please generate report first!"
      end
    end
  end
end
