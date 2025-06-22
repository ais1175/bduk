--[[
    This file is part of BDUK (BOII Development UI Kit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ BOII Development

    Support honest development — retain this credit. Don’t be that guy...
]]

--[[
#############################
#  ____   ____ _____ _____  #
# |  _ \ / __ \_   _|_   _| #
# | |_) | |  | || |   | |   #
# |  _ <| |  | || |   | |   #
# | |_) | |__| || |_ _| |_  #
# |____/ \____/_____|_____| #
#                           #                       
#############################                                         
#           BDUK            #
#          V0.1.1           #    
#############################
]]

fx_version "cerulean"
games { "gta5", "rdr3" }

name "bduk"
version "0.1.1"
description "BOII Development UI Kit."
author "boiidevelopment"
repository "https://github.com/boiidevelopment/bduk"
lua54 "yes"

fx_version "cerulean"
game "gta5"

ui_page "ui/index.html"
nui_callback_strict_mode "true"

files {
    "**"
}

--- Init
shared_script "init.lua"

--- Core
shared_script "main.lua"

--- Test code you can remove this :)
client_script "test.lua"
