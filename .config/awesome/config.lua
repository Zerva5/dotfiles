local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

local config = {}

config.desktop_hostname = "LMDESK"
config.laptop_hostname = "LMTHINK"

config.hostname = io.popen("uname -n"):read()


    if config.hostname == config.desktop_hostname then
        config.device = "Desktop"
    else
        config.device = "Laptop"
    end


--
--end

config.theme = {}

config.theme.path = "/home/lmayall/dotfiles/.config/awesome/"
config.theme.name = "subway"


config.scripts = "/home/lmayall/dotfiles/Scripts/"

config.layouts = {
     awful.layout.suit.tile,
     awful.layout.suit.floating
}

-- config.taglist = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"}
config.taglist = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}

config.modkey = "Mod4"

config.apps = {}

config.apps.terminal = "alacritty"
config.apps.web = "firefox"
config.apps.image_viewer = "sxiv"
config.apps.image_editor = "gimp"
config.apps.raw_editor = "darktable"
config.apps.launcher = "rofi -show run"




return config
