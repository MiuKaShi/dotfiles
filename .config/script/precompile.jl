try
    mkdir("sysimage")
catch e
    @warn "error while create sysimage folder: " e
end
cd("sysimage")
import Pkg
Pkg.activate(".")
Pkg.add("PackageCompiler")
Pkg.add("OhMyREPL")
Pkg.add("BenchmarkTools")
Pkg.add("Revise")
Pkg.add("Plots")
Pkg.add("IJulia")
Pkg.precompile()
using PackageCompiler, OhMyREPL, BenchmarkTools, IJulia, Plots, Revise
create_sysimage(["OhMyREPL", "BenchmarkTools", "IJulia", "Revise", "Plots"]; sysimage_path="sysimage.so")
cd("..")
exit()
