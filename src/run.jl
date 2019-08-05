
cfg = Dict{String,String}()
const bk = "↩"
const dt = ["raster", "network"]
const mm1 = ["pairwise", "advanced"] 

function run_builder()
    logo = raw"""

    `-````````````````````````````````````````````````
    -dd```````````````````````````````````````````````
    `.dh:``````````````````````````````````````.``````
    ```:ddddddddddhhdd+:-..``.-:ddddddhhhhddddhdd.````
    ``````-dddddddd.dddddddddhhhhhddddddddddddddddd```
    ````````````````ddddddddddddddddddddddddddddhd.```
    ```````````.ddddddddddddddddddddddddddddhhhd.`````
    ````````.ddddddddddddd```````````/dddddd/dddd:````
    ````.ddddddddd-----.``````````````````````````````
    ````.dddddd.````.ooo```````/o/```````:oo-`````````
    ``.````````````/oooo/o```oo/oo/o```oooo.:/o```````
    `ooo///o.````:o/`````oooo/`````-oooo.`````ooooooo-
    ``.`````/oo/o/```````oo/````````oo.````````````..`
    `````````oo/````````oo````````.o.`````````````````


    """
    blue    = "\033[34m"
    red     = "\033[31m"
    green   = "\033[32m"
    magenta = "\033[35m"
    normal  = "\033[0m\033[0m"
    
    welcome_message = raw"""
    Welcome to INIBuilder. 
    """
    # TODO: Styling the logo. Too much effort?
    logo = replace(logo, "d" => "$(red)d$(normal)")
    logo = replace(logo, "h" => "$(red)h$(normal)")
    logo = replace(logo, "o" => "$(blue)o$(normal)")
    print(logo)
    print(welcome_message)

    println("Step 1: Choose Data Type")

    n = request(RadioMenu(vcat(dt)))
    cfg["data_type"] = dt[n]

    println("Step 2: Choose Modelling Mode")
end
