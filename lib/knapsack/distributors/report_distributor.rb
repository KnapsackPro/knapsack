module Knapsack
  module Distributors
    class ReportDistributor < BaseDistributor
      def sorted_report
        @sorted_report ||= report.sort_by{|k,v| v}.reverse
      end

      def total_time_execution
        @total_time_execution ||= report.values.reduce(0, :+).to_f
      end

      def node_time_execution
        @node_time_execution ||= total_time_execution / ci_node_total
      end

      private

      def post_assign_spec_files_to_node
        assign_slow_spec_files
        assign_remaining_spec_files
      end

      def post_specs_for_node(node_index)
        node_spec = node_specs[node_index]
        return unless node_spec
        node_spec[:spec_files_with_time].map(&:first)
      end

      def default_node_specs
        @node_specs = []
        ci_node_total.times do |index|
          @node_specs << {
            node_index: index,
            time_left: node_time_execution,
            spec_files_with_time: []
          }
        end
      end

      def assign_slow_spec_files
        @not_assigned_spec_files = []
        @node_index = 0
        sorted_report.each do |spec_file_with_time|
          assign_slow_spec_file(spec_file_with_time)
          update_node_index
        end
      end

      def assign_slow_spec_file(spec_file_with_time)
        time = spec_file_with_time[1]
        time_left = node_specs[@node_index][:time_left] - time

        if time_left >= 0 or node_specs[@node_index][:spec_files_with_time].empty?
          node_specs[@node_index][:time_left] -= time
          node_specs[@node_index][:spec_files_with_time] << spec_file_with_time
        else
          @not_assigned_spec_files << spec_file_with_time
        end
      end

      def assign_remaining_spec_files
        @not_assigned_spec_files.each do |spec_file_with_time|
          index = node_with_max_time_left
          time = spec_file_with_time[1]
          node_specs[index][:time_left] -= time
          node_specs[index][:spec_files_with_time] << spec_file_with_time
        end
      end

      def node_with_max_time_left
        node_spec = node_specs.max { |a,b| a[:time_left] <=> b[:time_left] }
        node_spec[:node_index]
      end
    end
  end
end
