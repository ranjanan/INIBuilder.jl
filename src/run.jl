
cfg = Dict{String,String}()
const bk = "↩"
const dt = ["raster", "network"]
const mm1 = ["pairwise", "advanced"] 

function run_builder()
    logo = raw"""
     
    `-````````````````````````````````````````````````
    -ho```````````````````````````````````````````````
    `.sh:``````````````````````````````````````.``````
    ```:sho/::/+syhhys+:-..``.-://+osyhhhhso+ohdo.````
    ``````-/++//::-.:yhddddddhhhhhdddddddddddddddy-```
    ````````````````:ydddddddmdddddddddddddds++sh+.```
    ```````````.+/+sddddmmdysooo++ooohdmmmddhhho.`````
    ````````.-+dmmddmmmmy/```````````/oo+/::/+hmh:````
    ````.sdmdhhho/-----.``````````````````````````````
    ````.oy+oho.````.os-```````/y/```````:so-`````````
    ``.````````````/y+-:/-```:s/-:/:```-o+-.:/-```````
    `oyo///+.````:s/`````:o+o/`````-o+o+.`````-////yy-
    ``.`````/+-/o/```````-y/````````s+.````````````..`
    `````````.o/````````.:````````.:.`````````````````

    Welcome to INIBuilder. 

    """
    blue    = "\033[34m"
    red     = "\033[31m"
    green   = "\033[32m"
    magenta = "\033[35m"
    normal  = "\033[0m\033[0m"

    printstyled(logo, bold = true)

    println("Step 1: Choose Data Type")

    n = request(RadioMenu(vcat(dt)))
    cfg["data_type"] = dt[n]

    println("Step 2: Choose Modelling Mode")
end
