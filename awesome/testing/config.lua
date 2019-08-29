local awful = require("awful")
local beautiful = require("beautiful")

local config = {}

config.hostname = io.popen("uname -n"):read()
config.theme = {}

config.theme.path = "/home/lmayall/dotfiles/awesome/"
config.theme.name = "wind"

config.layouts = {
     awful.layout.suit.tile,
     awful.layout.suit.floating
}

config.modkey = "Mod4"

config.apps = {}

config.apps.terminal = "alacritty"
config.apps.web = "firefox"
config.apps.image_viewer = "sxiv"
config.apps.image_editor = "gimp"
config.apps.raw_editor = "darktable"


return config
