# Migration steps: from Knapsack to Knapsack Pro

Follow these steps to migrate from `knapsack` to `knapsack_pro` in 10 minutes.

Commands are provided to help you with each step.

> [!TIP]
> On Linux, you need to remove the `''` part from the `sed` commands. Also, you can ignore the `sed: no input files` warning that is printed when there's no substitution to perform.

## Steps

- [ ] Remove the `knapsack` gem:
   ```bash
   bundle remove knapsack
   ```

- [ ] Remove `Knapsack.load_tasks` from the `Rakefile` if present:
   ```bash
   sed -i '' '/Knapsack\.load_tasks/d' Rakefile
   ```

- [ ] Replace `require "knapsack"` with `require "knapsack_pro"`:
   ```bash
   grep --files-with-matches --recursive "require.*knapsack" . | xargs sed -i '' "s/'knapsack'/'knapsack_pro'/g"
   grep --files-with-matches --recursive "require.*knapsack" . | xargs sed -i '' 's/"knapsack"/"knapsack_pro"/g'
   ```

- [ ] Remove the following code from the test runner configuration:
   ```diff
   - Knapsack.tracker.config({
   -  enable_time_offset_warning: true,
   -  time_offset_in_seconds: 30
   - })

   - Knapsack.report.config({
   -  test_file_pattern: 'spec/**{,/*/**}/*_spec.rb', # ⬅️ Take note of this one for later
   -  report_path: 'knapsack_custom_report.json'
   - })
   ```

- [ ] Replace `Knapsack` with `KnapsackPro`:
   ```bash
   grep --files-with-matches --recursive "Knapsack\." . | xargs sed -i '' 's/Knapsack\./KnapsackPro./g'
   grep --files-with-matches --recursive "Knapsack::" . | xargs sed -i '' 's/Knapsack::/KnapsackPro::/g'
   ```

- [ ] Rename `KnapsackPro::Adapters::RspecAdapter` to `KnapsackPro::Adapters::RSpecAdapter`:
   ```bash
   grep --files-with-matches --recursive "KnapsackPro::Adapters::RspecAdapter" . | xargs sed -i '' 's/RspecAdapter/RSpecAdapter/g'
   ```

- [ ] Remove any line that mentions `KNAPSACK_GENERATE_REPORT` or `KNAPSACK_REPORT_PATH`:
   ```bash
   grep --files-with-matches --recursive "KNAPSACK_GENERATE_REPORT" . | xargs sed -i '' '/KNAPSACK_GENERATE_REPORT/d'
   grep --files-with-matches --recursive "KNAPSACK_REPORT_PATH" . | xargs sed -i '' '/KNAPSACK_REPORT_PATH/d'
   ```

- [ ] Rename ENVs from `KNAPSACK_X` to `KNAPSACK_PRO_X`:
   ```bash
   grep --files-with-matches --recursive "KNAPSACK_" . | xargs sed -i '' 's/KNAPSACK_/KNAPSACK_PRO_/g'
   ```

- [ ] Remove all the reports:
   ```bash
   rm knapsack_*_report.json
   ```

- [ ] [Configure Knapsack Pro](https://docs.knapsackpro.com/knapsack_pro-ruby/guide/)

- [ ] Ensure all the CI commands are updated:
   ```bash
   grep --files-with-matches --recursive "knapsack:spinach" . | xargs sed -i '' 's/knapsack:spinach/knapsack_pro:spinach/g'
   grep --files-with-matches --recursive "knapsack:" . | xargs sed -i '' 's/knapsack:/knapsack_pro:queue:/g'
   grep --files-with-matches --recursive "CI_NODE_TOTAL" . | xargs sed -i '' 's/CI_NODE_TOTAL/KNAPSACK_PRO_CI_NODE_TOTAL/g'
   grep --files-with-matches --recursive "CI_NODE_INDEX" . | xargs sed -i '' 's/CI_NODE_INDEX/KNAPSACK_PRO_CI_NODE_INDEX/g'
   ```

- [ ] If you removed `test_file_pattern` when deleting `Knapsack.report.config`, use [`KNAPSACK_PRO_TEST_FILE_PATTERN`](https://docs.knapsackpro.com/ruby/reference/#knapsack_pro_test_file_pattern) instead
