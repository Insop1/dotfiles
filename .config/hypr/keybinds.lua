local settings = require("settings")
local mainMod = settings.mainMod -- Sets "Windows" key as main modifier

local terminal    = settings.terminal
local fileManager = settings.fileManager
local menu        = settings.menu
local taskBar = settings.taskBar
local wallpaper = settings.wallpaper
local notifier = settings.notifier
local locker = settings.locker
local editor = settings.editor

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("menu-fuzzel.sh"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("maximize", "toggle"))
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(locker))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("cliphist-fuzzel.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("wallpaper-fuzzel.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("projects-fuzzel.sh"))

-- Resize

local ratios = { 0.6667, 1.0, 1.3333 }
local idx = {}

hl.bind(mainMod .. " + R", function()
  local win = hl.get_active_window()
  if win == nil or win.floating then return end

  local key = win.address
  idx[key] = (idx[key] or 2) % #ratios + 1
  hl.dispatch(hl.dsp.layout("splitratio " .. ratios[idx[key]] .. " exact"))
end)

hl.on("window.close", function(win)
  idx[win.address] = nil
end)

-- Restarting Waybar
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))

-- hjkl
-- Move focus
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot --

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && notify-send \"Screenshot\" \"Copied to clipboard\""))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


