module JuliaCallJuMP
import JuMP
import LinearAlgebra
import GLPK

greet() = print("Hello World!")

optimise(x, y) = x, y

# This function is from a JuMP tutorial. 
# See: https://nbviewer.jupyter.org/github/jump-dev/JuMPTutorials.jl/blob/master/notebook/modelling/network_flows.ipynb
function solve_shortest_path()
    G = [
    0 100 30  0  0;
    0   0 20  0  0;  
    0   0  0 10 60;
    0  15  0  0 50;
    0   0  0  0  0;
    ]

    n = size(G)[1]

    shortest_path = JuMP.Model(GLPK.Optimizer)

    JuMP.@variable(shortest_path, x[1:n,1:n], Bin)
    JuMP.@constraint(shortest_path, [i = 1:n, j = 1:n; G[i,j] == 0], x[i,j] == 0) # Arcs with zero cost are not a part of the path as they do no exist
    JuMP.@constraint(shortest_path, [i = 1:n; i != 1 && i != 2], sum(x[i,:]) == sum(x[:,i])) # Flow conservation constraint
    JuMP.@constraint(shortest_path, sum(x[1,:]) - sum(x[:,1]) == 1) # Flow coming out of source = 1
    JuMP.@constraint(shortest_path, sum(x[2,:]) - sum(x[:,2]) == -1) # Flowing coming out of destination = -1 i.e. Flow entering destination = 1  
    JuMP.@objective(shortest_path, Min, LinearAlgebra.dot(G, x))

    JuMP.optimize!(shortest_path)

    return JuMP.objective_value(shortest_path), JuMP.value.(x)
end


end # module
