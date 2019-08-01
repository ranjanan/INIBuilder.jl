using REPL
using REPL.TerminalMenus

mutable struct History
    path::String
end

h = History(homedir())
update!(h, path) = (h.path = path)

function filepicker()
    r = readdir()
    length(r) == 1 && return readdir()
    path = h.path
    printstyled("""
          Select a path: 
          """, bold=true)
    pick(path)
end

function pick(path) 
    isfile(path) && return normpath(path)
    r = alldir(path)
    l = request(RadioMenu(r, pagesize=10)) 
    println("---------------------------------")
    printstyled("Selected path: ", bold=true) 
    print("$(normpath(joinpath(path,r[l])))\n")
    println("---------------------------------")
    update!(h, path)
    pick(joinpath(path, r[l]))
end
alldir(path) = vcat("..", readdir(path))


