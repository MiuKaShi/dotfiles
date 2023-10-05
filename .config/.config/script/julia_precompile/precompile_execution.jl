@time begin
    using Revise, OhMyREPL, PyCall, IJulia, FileIO, JLD2, DataFrames, CSV, BenchmarkTools, StaticArrays
    x = 0:0.01:4.0
    y = sin.(x) .* exp.(x) .+ 0.1
end
