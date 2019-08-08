
cfg = Circuitscape.init_config()
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

    @label startover

    println()

    println("Step 1: Choose Data Type")

    n = request(RadioMenu(vcat(dt)))
    cfg["data_type"] = dt[n]
    is_raster = dt[n] == "raster"

    println()

    println("Step 2: Choose Modelling Mode")
    if is_raster 
        mm = ["pairwise", "advanced", "one-to-all", "all-to-one"]
    else
        mm = ["pairwise", "advanced"]
    end
    n = request(RadioMenu(vcat(mm)))
    cfg["scenario"] = mm[n]
    
    str = is_raster ? "resistance grid" : "network"  

    println()

    println("Step 3: Enter path to $str")
    path = filepicker()
    cfg["habitat_file"] = path

    println()

    println("Is this a resistance or conductance file?")
    is_res = ["resistances", "conductance"]
    n = request(RadioMenu(is_res))
    cfg["habitat_map_is_resistances"] = is_res[n]
    
    is_advanced = mm[n] == "advanced"

    if !is_advanced
        println()
        println("Step 4: Enter path to focal nodes:")
        path = filepicker()
        cfg["point_file"] = path
    else
        println()
        println("Step 4a: Enter path to source file") 
        path = filepicker()
        cfg["source_file"] = path
        println()
        println("Step 4b: Enter path to ground file") 
        path = filepicker()
        cfg["ground_file"] = path
    end

    println()

    println("Step 5: Choose solver")
    opt = ["cg+amg", "cholmod"]
    n = request(RadioMenu(opt))
    cfg["solver"] = opt[n]

    println()

    println("Step 6: Choose number of parallel processes")
    opt = collect(1:Sys.CPU_THREADS) |> x -> string.(x)
    n = request(RadioMenu(opt))
    
    println()

    println("Step 7: Choose outputs")
    opt = ["Current maps", "Voltage maps"]
    n = request(MultiSelectMenu(opt))
    1 in n && (cfg["write_cur_maps"] = "true")
    2 in n && (cfg["write_volt_maps"] = "true")

    println()

    println("Step 8: Choose output file name")
    name = readline(stdin) 

    println()

    println("Step 9: Choose output folder")
    path = folderpicker()
    cfg["output_file"] = normpath(joinpath(path, name))

    println()
    
    println("Step 10: Would you like to run Circuitscape?")
    opt = ["Yes", "Later"]
    n = request(RadioMenu(opt))
    n == 1 && Circuitscape.compute(cfg)
    if n == 2 
        println()
        Circuitscape.write_config(cfg)
        println("$name.ini written to $(normpath(path))")
        println()
        println("Would you to like to write another file?")
        l = RadioMenu(["Yes", "No"])
        n = request(l)
        n == 1 && @goto startover
        n == 2 && return
    end


end
