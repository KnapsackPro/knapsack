# knapsack gem

Knapsack splits tests evenly across parallel CI nodes to run fast CI build and save you time.

|                                              | knapsack gem | knapsack_pro gem |
| -------------------------------------------- | ------------ | ---------------- |
| __Is free__                                  | ✓ Yes        | ✓ Yes, [free plan](https://knapsackpro.com?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=free_plan) |
| __Regular Mode - static tests split__        | ✓ Yes        | ✓ Yes |
| __Queue Mode - a dynamic tests split__       | No           | ✓ Yes |
| __Tracking tests timing per commit, branch__ | No           | ✓ Yes |
| __Support for other programming languages__  | No           | ✓ Yes |
| __Support for CI providers__                 | limited      | ✓ Yes |
| __README__                                   | [Open README](http://docs.knapsackpro.com/ruby/knapsack) | [Open README](https://docs.knapsackpro.com/integration/) |

[Features of knapsack vs knapsack_pro Ruby gem](https://knapsackpro.com/features/ruby_knapsack_pro_vs_knapsack?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=ruby_knapsack_pro_vs_knapsack)

# Do you use Heroku?

Do you know Knapsack Pro Ruby gem is available as Heroku add-on that's currently in beta and it's free to all beta users? It works with your current CI server.
https://elements.heroku.com/addons/knapsack-pro

Knapsack Pro has Queue Mode that will split Ruby & JS tests in a dynamic way across parallel CI nodes to ensure each parallel job takes a similar time. Thanks to that there is no bottleneck in your CI pipelines.

__See introduction how the Knapsack Pro add-on works__
https://youtu.be/rmXES2N0_QU

You may also find useful article how to run parallel dynos on Heroku CI to complete tests faster
https://docs.knapsackpro.com/2019/how-to-run-tests-faster-on-heroku-ci-with-parallel-dynos

## Do you know

* Knapsack Pro is risk-free integration! Knapsack Pro runs tests in Fallback Mode if your CI servers can't reach our API for any reason.
* We don't need access to your repository. Knapsack Pro is just wrapper around test runner like RSpec, Cucumber, Minitest etc.
* Hundreds of developers use Knapsack Pro every day to run fast CI builds.
* It works with other programming languages.
