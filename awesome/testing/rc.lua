local awful = require("awful")
local math = require("math")
local gears = require("gears")
awful.client = require("awful.client")
awful.screen = require("awful.screen")
awful.mouse = require("awful.mouse")
awful.rules = require("awful.rules")
awful.menu = require("awful.menu")
awful.ewmh = require("awful.ewmh")
require("awful.autofocus")
require("awful.dbus")
require("awful.remote")
local wibox = require("wibox")
local beautiful = require("beautiful")

local config = require("config")

do
    beautiful.init(config.theme.path .. config.theme.name .. "/theme.lua")
end

local keybinds = require("keybinds")

local tag = require("tag")

local hostname = io.popen("uname -n"):read()

local config_path = "/home/lmayall/dotfiles/awesome"


if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

do
    awful.screen.connect_for_each_screen(function (s)

	    tag.Initialize(s)
	    

        
    end
    )
end

client.connect_signal("manage", function(c)
	c:move_to_tag(tag.main.Web.tag)
	tag.addSubtag(tag.main.Web, c)

end)

-- {{{ Key bindings
globalkeys = gears.table.join(keybinds.keyboard.global)

clientkeys = gears.table.join(keybinds.keyboard.client)

clientbuttons = gears.table.join(keybinds.mouse.client)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
-- All clients will match this rule.
{ rule = { },
  properties = { border_width = beautiful.border_width,
                 border_color = beautiful.border_normal,
                 focus = awful.client.focus.filter,
                 raise = true,
                 keys = clientkeys,
                 buttons = clientbuttons,
                 screen = awful.screen.preferred,
                 placement = awful.placement.no_overlap+awful.placement.no_offscreen
 }
},

-- Floating clients.
{ rule_any = {
    instance = {
      "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
      "pinentry",
    },
    class = {
      "Arandr",
      "Blueman-manager",
      "Gpick",
      "Kruler",
      "MessageWin",  -- kalarm.
      "Sxiv",
      "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
      "Wpa_gui",
      "veromix",
      "xtightvncviewer"},

    -- Note that the name property shown in xprop might be set slightly after creation of the client
    -- and the name shown there might not match defined rules here.
    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
      "ConfigManager",  -- Thunderbird's about:config.
      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true },

  rule_any = {
      class = {"code-oss", "Firefox", "darktable"},
  },
  properties = {floating = false},

  rule_any = {
      class = {"firefox"},

  },
  properties = {maximized = false},

  },


-- Add titlebars to normal clients and dialogs

}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
-- Set the windows at the slave,
-- i.e. put it at the end of others instead of setting it master.
-- if not awesome.startup then awful.client.setslave(c) end

if awesome.startup
  and not c.size_hints.user_position
  and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
end
end)




-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("compton &")
awful.spawn.with_shell("nm-applet &")
-- }}}
