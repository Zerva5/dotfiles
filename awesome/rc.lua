
local awful = require("awful")
local volume_control = require("volume-control")
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
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local xrandr = require("xrandr")
local foggy = require("foggy")
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

config = {}

config.keybinds = {}
config.keybinds.global = {}
config.keybinds.client = {}
config.keybinds.laptop = {}
config.keybinds.desktop = {}

config.func = {}

config.widget = {}

config.default = {}
config.default.autostart = {}
config.default.layout = {}

config.theme = {}
config.theme.path = config_path .. "/default"

do
-- Create a wibox for each screen and add it
    taglist_buttons = gears.table.join(
                awful.button({ }, 1, function(t) t:view_only() end)
    ) 

    tasklist_buttons = gears.table.join(
                 awful.button({ }, 1, function (c)
                                          if c == client.focus then
                                              c.minimized = true
                                          else
                                              c:emit_signal(
                                                  "request::activate",
                                                  "tasklist",
                                                  {raise = true}
                                              )
                                          end
                                      end))
    -- Defaults
    config.default.terminal = "alacritty"
    config.default.modkey = "Mod4"

    config.default.layout[1] = awful.layout.suit.tile
    config.default.layout[2] = awful.layout.suit.floating

    -- Theme stuff
    beautiful.init(config.theme.path .. "/theme.lua")
    config.theme.wallpaper = beautiful.wallpaper



    -- Widgets
    config.widget.clock = wibox.widget.textclock("%a %b %d, %H:%M")
    config.widget.systray = wibox.widget.systray()
    config.widget.volume = volume_control({})
    config.widget.cpu = require("awesome-wm-widgets.cpu-widget.cpu-widget")
    config.widget.ram = require("awesome-wm-widgets.ram-widget.ram-widget")

    if hostname == "lmayallThinkPad" then
        config.widget.battery = require("awesome-wm-widgets.battery-widget.battery")
    else
        config.widget.battery = nil
    end

    -- Functions
    config.func.set_wallpaper = function (s)
        if type(config.theme.wallpaper ) == "function" then
            config.theme.wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(config.theme.wallpaper, s, true)
    end

    awful.screen.connect_for_each_screen(function (s)

        config.func.set_wallpaper(s)
        
        awful.tag({ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[2])

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,

            style = {
                shape = gears.shape.rectangle,
            },

            layout = {
                spacing = 6,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    left  = 5,
                    right = 5,
                    widget = wibox.container.margin
                },
                id = "background_role",
                widget = wibox.container.background,

                
                create_callback = function(self, t, index, objects)
                    if next(t:clients()) == nil then
                        self.fg = "#113311"
                    end
                end,

                update_callback = function(self, t, index, objects)
                    if next(t:clients()) == nil then
                        self.fg = "#113311"
                    else
                        self.fg = beautiful.fg_focus
                    end
                end
            }
        }

        -- Create a tasklist widget
        -- s.mytasklist = awful.widget.tasklist {
        --     screen  = s,
        --     filter  = awful.widget.tasklist.filter.currenttags,
        --     buttons = tasklist_buttons
        -- }
        s.mytasklist = awful.widget.tasklist {
            screen   = s,
            filter   = awful.widget.tasklist.filter.currenttags,
            buttons  = tasklist_buttons,

            style = {
                shape_border_width = 4,
                shape  = gears.shape.rectangle,
            },

            layout = {
                spacing = 3,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            id = "task_name",
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    left  = 10,
                    right = 10,
                    widget = wibox.container.margin
                },
                id = "background_role",
                widget = wibox.container.background,

                create_callback = function(self, c, index, objects)
                    self:get_children_by_id("task_name")[1].text = c.class
                    
                    if c == client.focus then
                        self.fg = beautiful.fg_focus
                    else
                        self.fg = beautiful.fg_normal
                    end
                end,
                update_callback = function(self, c, index, objects)
                    self:get_children_by_id("task_name")[1].text = c.class

                    if c == client.focus then
                        self.fg = beautiful.fg_focus
                    else
                        self.fg = beautiful.fg_normal
                    end
                end,
            }
        }

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s })

        -- Add widgets to the wibox
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            { -- Left widgets
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        s.mytaglist,
                    },
                    widget = wibox.container.margin,
                    margins = 2,
                    color = beautiful.fg_normal
                },
                layout = wibox.layout.fixed.horizontal
            },
            {
                layout = wibox.layout.fixed.horizontal,
                s.mytasklist, -- Middle widget


            },
            { -- Right widgets
	    	{
		    {
                        layout = wibox.layout.fixed.horizontal,
                        config.widget.volume,
                        wibox.widget.systray(),
                        config.widget.clock
	    	    },
		    widget = wibox.container.margin,
		    margins = 2,
		    color = beautiful.fg_normal
		},
		layout = wibox.layout.fixed.horizontal,
            },
        }

        -- body
    end)

    config.func.spawnTerminal = function ()
        awful.spawn(config.default.terminal)
    end

    config.func.fullscreen = function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end

    config.func.launcher = function()
        awful.spawn.with_shell("rofi -show run &")
    end




    -- KeyBinds
    config.keybinds.global.mod = {}
    config.keybinds.global.mod.terminal = {"Return", config.func.spawnTerminal}
    config.keybinds.global.mod.launcher = {"d", config.func.launcher}

    config.keybinds.global.mod.nextClient = {"l", function()awful.client.focus.byidx(1) end}
    config.keybinds.global.mod.prevClient = {"h", function()awful.client.focus.byidx(-1) end}

    config.keybinds.global.mod.nextTag = {"m", awful.tag.viewnext}
    config.keybinds.global.mod.prevTag = {"n", awful.tag.viewprev}

    config.keybinds.global.volumeUp = {"XF86AudioRaiseVolume", function() config.widget.volume:up() end}
    config.keybinds.global.volumeDown = {"XF86AudioLowerVolume", function() config.widget.volume:down() end}

    -- laptop keybinds
    config.keybinds.laptop.mod = {}
    config.keybinds.laptop.volumeMute = {"XF86AudioMute", function() config.widget.volume:toggle() end}
    config.keybinds.laptop.fullscreen = {"XF86LaunchA", config.func.fullscreen}

    config.keybinds.laptop.mod.songkeyNext = {"]", function() awful.spawn.with_shell("playerctl next") end}
    config.keybinds.laptop.mod.songkeyPrev = {"[", function() awful.spawn.with_shell("playerctl previous") end}
    config.keybinds.laptop.mod.songkeyPause = {"p", function() awful.spawn.with_shell("playerctl play-pause") end}



    config.keybinds.global.songNext = {"XF86AudioNext", function() awful.spawn.with_shell("playerctl next") end}
    config.keybinds.global.songPrev = {"XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous") end}
    config.keybinds.global.songPause = {"XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause") end}

   -- body

    config.keybinds.client.mod = {}
    config.keybinds.client.mod.kill = "q"
    config.keybinds.client.fullscreen = {"F11", config.func.fullscreen}

    config.keybinds.client.mod.minClient = {"k", function(c)c.minimized = true end}
    config.keybinds.client.mod.maxClient = {"j", function(c)c.minimized = false end}


end


terminal = config.default.terminal
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Set modkey
modkey = config.default.modkey

-- Set layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}


-- {{{ Key bindings
globalkeys = gears.table.join(

-- Laptop specific binds
    awful.key({}, config.keybinds.laptop.volumeMute[1], config.keybinds.laptop.volumeMute[2]),
    awful.key({modkey}, config.keybinds.laptop.mod.songkeyNext[1], config.keybinds.laptop.mod.songkeyNext[2]),
    awful.key({modkey}, config.keybinds.laptop.mod.songkeyPrev[1], config.keybinds.laptop.mod.songkeyPrev[2]),
    awful.key({modkey}, config.keybinds.laptop.mod.songkeyPause[1], config.keybinds.laptop.mod.songkeyPause[2]),



    awful.key({modkey}, config.keybinds.global.mod.terminal[1], config.keybinds.global.mod.terminal[2]),
    awful.key({modkey}, config.keybinds.global.mod.launcher[1], config.keybinds.global.mod.launcher[2]),

    awful.key({modkey}, config.keybinds.global.mod.nextTag[1], config.keybinds.global.mod.nextTag[2]),
    awful.key({modkey}, config.keybinds.global.mod.prevTag[1], config.keybinds.global.mod.prevTag[2]),


    awful.key({}, config.keybinds.global.volumeUp[1], config.keybinds.global.volumeUp[2]),
    awful.key({}, config.keybinds.global.volumeDown[1], config.keybinds.global.volumeDown[2]),

    awful.key({}, config.keybinds.global.songNext[1], config.keybinds.global.songNext[2]),
    awful.key({}, config.keybinds.global.songPrev[1], config.keybinds.global.songPrev[2]),
    awful.key({}, config.keybinds.global.songPause[1], config.keybinds.global.songPause[2]),

    awful.key({modkey}, config.keybinds.global.mod.nextClient[1], config.keybinds.global.mod.nextClient[2]),
    awful.key({modkey}, config.keybinds.global.mod.prevClient[1], config.keybinds.global.mod.prevClient[2]),

    awful.key({ modkey, "Control" }, "r", awesome.restart),

    awful.key({ modkey, "Shift" }, "n", function ()
                        if client.focus then
			    local tagIndex = (client.focus.first_tag.index - 2) % 10 + 1
                            local tag = client.focus.screen.tags[tagIndex]
                            if tag then
                                client.focus:move_to_tag(tag)
				awful.tag.viewprev()
                            end
                        end
                    end),
    awful.key({ modkey, "Shift" }, "m", function ()
                        if client.focus then
			    local tagIndex = (client.focus.first_tag.index) % 10 + 1
                            local tag = client.focus.screen.tags[tagIndex]
                            if tag then
                                client.focus:move_to_tag(tag)
				awful.tag.viewnext()
                            end
                        end
                    end),

    awful.key({modkey}, config.keybinds.client.mod.maxClient[1], function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:emit_signal(
              "request::activate", "key.unminimize", {raise = true}
          )
        end
    end)

)

clientkeys = gears.table.join(
    awful.key({modkey}, config.keybinds.client.mod.kill, function(c) c:kill() end),
    awful.key({}, config.keybinds.client.fullscreen[1], config.keybinds.client.fullscreen[2]),

    awful.key({}, config.keybinds.laptop.fullscreen[1], config.keybinds.laptop.fullscreen[2]),
    
    awful.key({modkey}, config.keybinds.client.mod.minClient[1], config.keybinds.client.mod.minClient[2])

)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)






for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            tag:view_only()
                        end
                    end,
                    {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            awful.tag.viewtoggle(tag)
                        end
                    end,
                    {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end,
                    {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:toggle_tag(tag)
                            end
                        end
                    end,
                    {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
    end
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
      class = {"code-oss", "Firefox"},
  },
  properties = {floating = false}},


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
