ENV["PYTHON"] = ""
ENV["JULIA_EDITOR"] = "nvim"
JULIA_NUM_THREADS = 6

Base.atreplinit() do repl
    @eval begin
        @async @eval using Revise
        @async @eval using BenchmarkTools
        import OhMyREPL as OMR
        import Crayons as C
        promptfn() = "(" * splitpath(Base.active_project())[end-1] * ") julia> "
        OMR.input_prompt!(promptfn)
        OMR.colorscheme!("GruvboxDark")
        OMR.enable_pass!("RainbowBrackets", true)
        OMR.Passes.BracketHighlighter.setcrayon!(C.Crayon(foreground=:blue))
        OMR.Passes.RainbowBrackets.activate_256colors()
    end
end
