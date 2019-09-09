# [Open README](http://docs.knapsackpro.com/ruby/knapsack)

# Do you use Heroku?

Do you know Knapsack Pro Ruby gem is available as Heroku add-on that's currently in beta and it's free to all beta users? It works with your current CI server.
https://elements.heroku.com/addons/knapsack-pro

Knapsack Pro has Queue Mode that will split Ruby & JS tests in a dynamic way across parallel CI nodes to ensure each parallel job takes a similar time. Thanks to that there is no bottleneck in your CI pipelines.

__See introduction how the Knapsack Pro add-on works__
https://youtu.be/rmXES2N0_QU

You may also find useful article how to run parallel dynos on Heroku CI to complete tests faster
https://docs.knapsackpro.com/2019/how-to-run-tests-faster-on-heroku-ci-with-parallel-dynos

## Do you know

* Adding 3rd party tool to CI is risky so Knapsack Pro can run your tests in Fallback Mode even when our API is not available.
* We don't need access to your repository. Knapsack Pro is just wrapper around test runner like RSpec, Cucumber, Minitest etc.
* Hundreds of developers use Knapsack Pro every day to run fast CI builds.
