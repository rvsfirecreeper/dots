------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

local monitors = {}

function monitors.init()
  hl.monitor({
      output   = "DP-2",
      mode     = "2560x1440@165",
      position = "0x0",
      scale    = "1",
  })
  hl.monitor({
      output   = "",
      mode     = "preferred",
      position = "auto",
      scale    = "1",
  })
end

return monitors
