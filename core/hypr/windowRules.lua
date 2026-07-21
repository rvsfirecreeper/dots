--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local windowrules = {}

function windowrules.activate()
  hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
  })

  hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
      class      = "^$",
      title      = "^$",
      xwayland   = true,
      float      = true,
      fullscreen = false,
      pin        = false,
    },

    no_focus = true,
  })

  hl.layer_rule({
      name  = "blur_quickshell",
      match = { namespace = "^.*quickshell.*$" },
      blur = true,
      blur_popups = true,
      ignore_alpha = 0.1,
  })

  -- Hyprland-run windowrule
  hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
  })
end

return windowrules
