# Knapsack

<p align="center">
  <a href="https://knapsackpro.com?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=hero_logo">
    <img alt="Knapsack" src="./.github/assets/knapsack-diamonds.png" width="300" height="300" style="max-width: 100%;" />
  </a>
</p>

<h3 align="center">Speed up your tests</h3>
<p align="center">Run your 1-hour test suite in 2 minutes with optimal parallelisation on your existing CI infrastructure</p>

---

<div align="center">
  <a href="https://rubygems.org/gems/knapsack">
    <img alt="Gem Version" src="https://badge.fury.io/rb/knapsack.svg" />
  </a>
</div>

<br />
<br />

Knapsack wraps your current test runner and works with your existing CI infrastructure to split tests optimally.

It comes in two flavors, `knapsack` and `knapsack_pro`:

|                                 | `knapsack` | `knapsack_pro`                          |
| ------------------------------- | ---------- | --------------------------------------- |
| Free                            | ✅         | ✅ [Free plan](https://knapsackpro.com?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=free_plan) |
| Static split                    | ✅         | ✅                                      |
| [Dynamic split](https://docs.knapsackpro.com/overview/#queue-mode-dynamic-split)       | ❌ | ✅ |
| [Split by test examples](https://docs.knapsackpro.com/ruby/split-by-test-examples/)    | ❌ | ✅ |
| Graphs, metrics, and stats      | ❌         | ✅                                      |
| Programming languages           | 🤞 (Ruby)  | ✅ (Ruby, Cypress, Jest, SDK/API)       |
| CI providers                    | 🤞 Limited | ✅ (All)                                |
| [Heroku add-on](https://elements.heroku.com/addons/knapsack-pro)                       | ❌ | ✅ |
| Additional features             | ❌         | 🤘 ([Overview](https://docs.knapsackpro.com/overview/)) |
|                                 | [Install](http://docs.knapsackpro.com/ruby/knapsack) | [Install](https://docs.knapsackpro.com) |

[`knapsack` vs `knapsack_pro` full comparison](https://knapsackpro.com/features/ruby_knapsack_pro_vs_knapsack?utm_source=github&utm_medium=readme&utm_campaign=knapsack_gem&utm_content=ruby_knapsack_pro_vs_knapsack)

# Migrate from `knapsack` to `knapsack_pro`

If you are already using `knapsack` and want to give `knapsack_pro` a try, here's [how to migrate in 10 minutes](./MIGRATE_TO_KNAPSACK_PRO.md).
