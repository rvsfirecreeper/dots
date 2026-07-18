---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "{{terminal}}"
local filemanager = "{{terminal}} yazi"
local menu        = "wofi"


require("monitors").init()

local daemons = require("daemons")
hl.on("hyprland.start", daemons.start)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

require("perms").enforce()

-----------------------
---- LOOK AND FEEL ----
-----------------------
local colors = require("colors")
require("looks").customize(colors)

require("layouts").configure()

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

require("input").activate()

require("binds").init(terminal, menu, filemanager)

require("windowRules").activate()
