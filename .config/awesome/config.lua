local wibox = require("wibox")
local awful = require("awful")

local config = {}

config.apps = {}

config.modkey = "Mod4"

config.scaling = 1

config.apps.terminal = "alacritty"

config.colors = {
   "#a972cb",
   "#ef6eae",
   "#ff7f82",
   "#ffa260",
   "#e4cb58",
   "#8fc866",
   "#19bc8b"
}

config.s = {}

config.s.main = {
   taglist = {"WEBS", "FILE", "WORK", "TERM", "MUSI", "CHAT", "MISC"}
}

config.s.vert = {
   taglist = {"FF", "FE", "DC", "SP", "I", "II", "III"}
}

config.mainScreen = 1

return config

