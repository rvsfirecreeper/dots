-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

local daemons = {}
function daemons.start()
    hl.exec_cmd(terminal)
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("swayidle before-sleep 'qs -p ~/.config/quickshell/Lock.qml'")
    hl.exec_cmd("quickshell -p ~/.config/quickshell/Bar.qml")
end

return daemons
