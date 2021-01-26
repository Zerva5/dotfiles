-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local keybinds = require("keybinds")
local config = require("config")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/lmayall/dotfiles/.config/awesome/themes/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor


modkey = "Mod4"
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        --awful.layout.suit.floating,
        awful.layout.suit.tile,
    })
end)
-- }}}

-- {{{ Wibar


-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create tiling wallpaper
awful.spawn.easy_async_with_shell("hsetroot -tile " .. beautiful.wallpaper .. " -tint \\#101010")

-- screen.connect_signal("request::wallpaper", function(s) -- 
    -- Wallpaper
    -- if beautiful.wallpaper then -- 
    --     local wallpaper = beautiful.wallpaper
    --     -- If wallpaper is a function, call it with the screen
    --     if type(wallpaper) == "function" then
    --         wallpaper = wallpaper(s)
    --     end
    --     gears.wallpaper.maximized(wallpaper, s, true)
                         -- end
                         
-- end)   

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({"WORK","WEBS", "TERM", "MUSI", "CHAT", "FILE", "MISC"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
        widget_template = {
           {
              -- {
                 {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                 },
                 widget = wibox.container.margin,
                 left = beautiful.taglist_margin,
                 right = beautiful.taglist_margin,
              -- },
--               {
--                  {
--                     widget = wibox.widget.progressbar,
--                     max_value = 1,
--                     value = .5,
--                     forced_width = 1,
--                  },
--                  layout = wibox.layout.fixed.vertical,
--                  forced_width = 10,
-- --                 widget = wibox.container.rotate,
-- --                 direction = 'north',
                 
                 
-- --                 bottom = 2, -- 
-- --                 color = "#ff0000",

--               },
--               layout = wibox.layout.fixed.vertical,
           },
           widget = wibox.container.margin,
           bottom = 2,
           color = "#ff7f82",
           --width = 3,

           create_callback = function(self, c3, index, objects)
              self.color = config.colors[index]

              if next(c3:clients()) == nill then
                 self.color = "#202020"
              else
                 self.color = config.colors[index]
              end
              
           end,

           update_callback = function(self, c3, index, objects)
              if next(c3:clients()) == nill then
                 self.color = "#202020"
              else
                 self.color = config.colors[index]
              end

           end,
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,

        widget_template = {
           {
              id = 'text_role',
              widget = wibox.widget.textbox,
           },
           widget = wibox.container.place,
           valign = "center",
           halign = "center",
        },
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s , height = beautiful.wibar_height})

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({config.modkey }, 4, awful.tag.viewprev),
    awful.button({ config.modkey}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(keybinds.keyboard.global)

clientkeys = gears.table.join(keybinds.keyboard.client)

clientbuttons = gears.table.join(keybinds.mouse.client)

-- Set keys
root.keys(globalkeys)
--
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings(clientkeys)
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            --key = clientkeys,
            buttons = clientbuttons,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true      }
    }

end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
