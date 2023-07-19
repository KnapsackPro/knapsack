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

    def test_file_pattern
      config[:test_file_pattern] || raise('Missing test_file_pattern')
    end

    def save
      File.open(report_path, 'w+') do |f|
        f.write(report_json)
      end
    end

    def save_and_merge
      File.open(report_path, 'a+') do |f|
          #read in the entire json into a variable, add the new one(s) into the hash, write the result
        existing_times = JSON.parse(f.read.delete!("\n")).to_hash #convert file to hash so we can merge in
        new_times = JSON.parse(report_json).to_hash unless report_json.nil?

        existing_times = existing_times.merge(new_times) unless new_times.nil? || existing_times.nil?
        final_copy = JSON.pretty_generate(existing_times)

        f.truncate(0) # clear existing content
        f.write(final_copy)
      end
    end

    def open
      report = File.read(report_path)
      JSON.parse(report)
    rescue Errno::ENOENT
      raise "Knapsack report file #{report_path} doesn't exist. Please generate report first!"
    end

    private

    def report_json
      Presenter.report_json
    end
  end
end
