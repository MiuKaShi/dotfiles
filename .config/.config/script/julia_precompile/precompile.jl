#!/usr/bin/env julia
try
    mkdir("sysimage")
catch e
    @warn "error while create sysimage folder: " e
end
cd("sysimage")

import Pkg
Pkg.update()
Pkg.add("PackageCompiler")

using PackageCompiler

packages = [
    :OhMyREPL, :IJulia,
    :FileIO, :JLD2, :DataFrames,
    :CSV, :BenchmarkTools,
    :StaticArrays
]

create_sysimage(
    packages;
    precompile_execution_file="../precompile_execution.jl",
    sysimage_path="mysys.so",
)

cd("..")
exit()
