require 'yaml'
require 'json'

module Knapsack
  class Presenter
    class << self
      def report_yml
        Knapsack.tracker.test_files_with_time.to_yaml
      end

      def report_json
        JSON.pretty_generate(Knapsack.tracker.test_files_with_time)
      end

      def report_details
        "Knapsack report was generated. Preview:\n" + Presenter.report_json
      end

      def global_time
        global_time = pretty_seconds(Knapsack.tracker.global_time)
        "\nKnapsack global time execution for tests: #{global_time}"
      end

      def time_offset
        "Time offset: #{Knapsack.tracker.config[:time_offset_in_seconds]}s"
      end

      def max_allowed_node_time_execution
        max_node_time_execution = pretty_seconds(Knapsack.tracker.max_node_time_execution)
        "Max allowed node time execution: #{max_node_time_execution}"
      end

      def exceeded_time
        exceeded_time = pretty_seconds(Knapsack.tracker.exceeded_time)
        "Exceeded time: #{exceeded_time}"
      end

      def time_offset_log_level
        if Knapsack.tracker.time_exceeded?
          Knapsack::Logger::WARN
        else
          Knapsack::Logger::INFO
        end
      end

      def time_offset_warning
        str = %{\n========= Knapsack Time Offset Warning ==========
#{Presenter.time_offset}
#{Presenter.max_allowed_node_time_execution}
#{Presenter.exceeded_time}
        }
        if Knapsack.tracker.time_exceeded?
          str << %{
Test on this CI node ran for longer than the max allowed node time execution.
Please regenerate your knapsack report.

If that doesn't help, you can split your slowest test files into smaller files, or bump up the time_offset_in_seconds setting.

You can also allow the knapsack_pro gem to automatically divide your slow test files across parallel CI nodes.
https://knapsackpro.com/faq/question/how-to-auto-split-test-files-by-test-cases-on-parallel-jobs-ci-nodes?utm_source=knapsack_gem&utm_medium=knapsack_gem_output&utm_campaign=knapsack_gem_time_offset_warning
}
        else
          str << %{
Global time execution for this CI node is fine.
Happy testing!}
        end
        str << "\n\nNeed explanation? See FAQ:"
        str << "\nhttps://docs.knapsackpro.com/ruby/knapsack#faq"
        str << "\n=================================================\n"
        str << %{Read up on the benefits of a dynamic test split with Knapsack Pro Queue Mode:
https://docs.knapsackpro.com/2020/how-to-speed-up-ruby-and-javascript-tests-with-ci-parallelisation

Sign up for Knapsack Pro here:
https://knapsackpro.com}
        str << "\n=================================================\n"
        str
      end

      def pretty_seconds(seconds)
        sign = ''

        if seconds < 0
          seconds = seconds*-1
          sign = '-'
        end

        return "#{sign}#{seconds}s" if seconds.abs < 1

        time = Time.at(seconds).gmtime.strftime('%Hh %Mm %Ss')
        time_without_zeros = time.gsub(/00(h|m|s)/, '').strip
        sign + time_without_zeros
      end
    end
  end
end
