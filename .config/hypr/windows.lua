local settings = require("settings")
local mainMod = settings.mainMod

-- unscale XWayland
hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

hl.config {
  render = {
    direct_scanout = 1
  }
}

hl.window_rule({
  match = { class = "osu!" },
  fullscreen = true,
  immediate = true,
  fullscreen_state = "2 0",
})

-- Window rules for special float windows 

-- Window Rules for popups
local LANDSCAPE = {900, 560}
local PORTRAIT = {600, 820}
local popups = {
  { name = "pavucontrol-popup", class = "org.pulseaudio.pavucontrol" },
  { name = "blueman-popup", class = "blueman-manager" },
  { name = "nmtui-popup", class = "nmtui-popup", size = PORTRAIT },
  { name = "wlctl-popup", class = "wlctl-popup", size = PORTRAIT },
  { name = "bluetui-popup", class = "bluetui-popup", size = PORTRAIT  },
}

for _, app in ipairs(popups) do
  hl.window_rule({
    name = app.name,
    match = { class = app.class },

    float = true,
    center = true,
    size = app.size or LANDSCAPE,
  })
end

-- obs
local obs = {
   window = "class:com.obsproject.Studio"
}
hl.bind(mainMod .. " + PAUSE", hl.dsp.pass(obs))
