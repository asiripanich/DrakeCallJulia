# This is where you write your drake plan.
# Details: https://books.ropensci.org/drake/plans.html
# julia <- JuliaCall::julia_setup(sysimage_path  = "Sysimage.so")

plan <- drake_plan(
  x = 1,
  julia = JuliaCall::julia_setup(sysimage_path  = "Sysimage.so"),
  optimisation_result = optimise(julia, x),
  shorth_path_result = solve_shortest_path(julia)
)
