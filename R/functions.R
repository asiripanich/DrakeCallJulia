# Custom functions are an important part of a drake workflow.
# This is where you write them.
# Details: https://books.ropensci.org/drake/plans.html#functions


optimise <- function(x) {
  JuliaCall::julia_setup()
  julia_library("JuliaCallJuMP")
  julia_eval("JuliaCallJuMP.optimise()")
}