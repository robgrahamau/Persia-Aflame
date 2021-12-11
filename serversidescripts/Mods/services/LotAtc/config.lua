lotatc_inst.options =  {
  -------------------------------------------------------------------
  --- You can copy this file to config.custom.lua file to make modifications
  --- config.custom.lua will not be overwrite on each install/update
  --- this one will be overwritten on each install/update of LotAtc
  -------------------------------------------------------------------


    ----------------------------------------------------------------------
    -- Common setup
    ----------------------------------------------------------------------
    -- Enable LotAtc
    -- (default=true)
    use_atc = true,

    -- LotAtc Server port
    -- (default=10310)
    port = 10310,

    -- Red password
    -- Put "" to disable it
    -- (default="red")
    red_password = "red",

    -- Blue password
    -- Put "" to disable it
    -- (default="blue")
    blue_password = "blue",

    -- Limitations of red clients
    -- -1 means no limit
    -- (default=-1)
    red_max_clients = -1,

    -- Limitations of blue clients
    -- -1 means no limit
    -- (default=-1)
    blue_max_clients = -1,



    ----------------------------------------------------------------------
    -- Virtual awacs
    ----------------------------------------------------------------------
    -- All units with this name (or human pilot group) will be AWACS
    -- void text disables the feature
    -- (default="")
    virtual_awacs_name = "",

    -- Radius detection range in kilometer for virtual AWACS ( must be > 5km )
    -- (default=400)
    virtual_awacs_range = 400,



    ----------------------------------------------------------------------
    -- Some radar globals
    ----------------------------------------------------------------------
    -- All units with name containing this string will never be part of radar coverage
    -- Works on any unit (plane, SAM, ship...)
    -- void text disables the feature
    -- (default="lotatc_ignore_")
    ignore_radar_name = "lotatc_ignore_",

    -- Minimal detection range in meters to be considered as part of
    -- radar coverage by LotAtc.
    -- (default=5001)
    minimal_detection_limit = 5001,



    ----------------------------------------------------------------------
    -- Logs
    ----------------------------------------------------------------------
    -- Log generation for server, false to disable
    -- (default=true)
    use_log = true,



    ----------------------------------------------------------------------
    -- Chat
    ----------------------------------------------------------------------
    -- Interact with DCS chat
    -- (default=true)
    use_chat = true,

    -- Filter command starting with, lua pattern
    -- (default={"^-.*"})
    chat_filter = {"^-.*"},

    -- Show connect message in DCS
    -- when LotAtc user connect/disconnect
    -- (default="none")
    -- Values are:
    --    "none" : no message in DCS
    --    "coalition" : message for coalition for LotAtc users in same coalition
    --    "all" : message for all for all LotAtc users
    chat_connect_message = "none",



    ----------------------------------------------------------------------
    -- Dedicated use
    ----------------------------------------------------------------------
    -- DCS Dedicated mode enable
    -- Profile will be set from the dedicated_profile below
    -- (default=false)
    dedicated_mode = false,

    -- For dedicated mode only, use this profile
    -- (default="realistic.lua")
    dedicated_profile = "realistic.lua",



    ----------------------------------------------------------------------
    -- Server authentification
    ----------------------------------------------------------------------
    -- Block connections that are already connected as DCS pilots
    -- (default="none")
    -- Values are:
    --    "none" : No block
    --    "all" : Everybody connected on DCS
    --    "pilots" : Only blocks DCS pilots (spectator not blocked)
    block_dcs_ip = "none",

    -- User/password list
    -- If a file is set, only user/password in this file could connect
    -- this file define also whitelist/blacklist
    -- For file path, path are relative to mods/LotAtc directoy
    -- but you can set absolute path also
    -- Format is JSON
    -- (default="")
    allowed_users_file = "",

    -- Server commands like pause/unpause from advanced client
    -- To enable admin commands you must:
    --  1/ use_admin_commands = true
    --  2/ add users in a json file specified by allowed_users_file
    --  3/ use advanced client license
    -- (default=false)
    use_admin_commands = false,



    ----------------------------------------------------------------------
    -- Plugins
    ----------------------------------------------------------------------
    -- Dump stats in Json for external software
    -- (default=false)
    dump_json_stats = false,

    -- stats file path, path are relative to mods/LotAtc directoy
    -- but you can set absolute path also
    -- (default="stats.json")
    dump_json_filename = "stats.json",

    -- Enable CSV file export of the computed tactical situation
    -- For monomodelisation, each radar will generate its own view + datalink
    -- (default=false)
    export_log = false,

    -- Enable TacView file export of the computed tactical situation
    -- For monomodelisation, each radar will generate its own view + datalink
    -- (default=false)
    export_tacview = false,



    ----------------------------------------------------------------------
    -- SRS
    ----------------------------------------------------------------------
    -- Enable SRS transponder function
    -- (default=true)
    srs_use_transponder = true,

    -- SRS transponder port
    -- (default=10712)
    srs_transponder_port = 10712,

    -- SRS server
    -- By default use local SRS server on same computer than DCS host
    -- (default="127.0.0.1")
    srs_server = "127.0.0.1",



    ----------------------------------------------------------------------
    -- Server
    ----------------------------------------------------------------------
    -- Enable Json server used for LotAtc Link
    -- WIP
    -- (default=true)
    use_jsonserver = true,

    -- Port for JSon communication
    -- Should be the same in lotatcMissionServer.lua
    -- (default=8081)
    jsonserver_port = 8081,



    ----------------------------------------------------------------------
    -- Optimisation flags [BE CAREFUL WITH THEM]
    ----------------------------------------------------------------------
    -- Number of seconds between data extraction
    -- Lower can reduce performances
    -- (default=2)
    update_time = 2,

    -- Search for new unit every n seconds
    -- (default=10)
    update_search_for_new = 10,

    -- Maximum number of units updated in each block of data
    -- (default=50)
    max_loop_unit = 50,

    -- Minimum frame update time in seconds
    -- (default=0.3)
    minimum_frame_update = 0.3,



    ----------------------------------------------------------------------
    -- Debug/test ONLY (SHOULD BE FALSE)
    ----------------------------------------------------------------------
    -- Enable verbose output in dcs.log, useful to report problems
    -- BIG PERFORMANCES IMPACT
    -- (default=false)
    enable_debug = false,

    -- Enable performances output, useful to report problems
    -- (default=false)
    perfs_tests = false,

}
