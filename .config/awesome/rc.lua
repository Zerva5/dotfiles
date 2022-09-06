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

beautiful.init("/home/lmayall/dotfiles/.config/awesome/themes/" .. awesome.hostname .. ".lua")

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
--awful.spawn.easy_async_with_shell("hsetroot -tile " .. beautiful.wallpaper .. " -tint \\#101010")
awful.spawn.easy_async_with_shell("sh /home/lmayall/dotfiles/Scripts/Laptop/WMStart.sh")


screen.connect_signal("request::wallpaper", function(s) -- 
    --Wallpaper
    if beautiful.wallpaper then -- 
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
                         end
                         
end)   

screen.connect_signal("request::desktop_decoration", function(s)


                         -- Each screen has its own tag table.
                         if (s.index == 1) then
                            configScreen = config.s.main
                            s.isMain = 1
                         elseif (s.index == 2) then
                            configScreen = config.s.vert
                            s.isMain = 0
                         end
                         
                         awful.tag(configScreen.taglist, s, awful.layout.layouts[1])

                         if(s.isMain == 0) then 
                            for k,v in pairs(s.tags) do
                               --naughty.notify({text = tostring(v)})
                               awful.tag.incnmaster(1, v)
                            end
                         end
                         
                            
                               
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
           bottom = 4, -- normally 2
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
                {
                   {
                   {
                      {
                         {
                            widget = awful.widget.clienticon,
                            id = "icon",
                         },
                         top = 2,
                         bottom = 2,
                         widget = wibox.container.margin,
                      },
                      {
                         {
                            {
                               widget = wibox.widget.textbox,
                               id = "sep_text",
                               text = "",
                               font = "FontAwesome " .. 12 * beautiful.scale,
                            },
                            widget = wibox.container.margin,
                            left = 3,
                            right = 3,
                         },
                         id = "sep_bg",
                         widget = wibox.container.background,
                         fg = beautiful.fg_focus
                      },
                      {
                         id = 'class_text',
                         widget = wibox.widget.textbox
                      },
                      layout = wibox.layout.fixed.horizontal,
                      --id     = 'clienticon',
                      --widget = awful.widget.clienticon,

                   },
                   widget = wibox.container.margin,
                   left = 10,
                   right = 10,
                   },
                   widget = wibox.container.margin,
                   id = "bottom_color",
                   bottom = 3,
                   color = "#ff0000"
                },
                widget = wibox.container.background,
                id = "main_bg",
                fg = "#ff0000"
             },
             widget = wibox.container.place,
             valign = "center",
             halign = "center",

             create_callback = function(self, c, index, objects)
                --text.fg = "#FF0000"
                class_text = self:get_children_by_id('class_text')[1]
                sep_text = self:get_children_by_id('sep_text')[1]
                sep_bg = self:get_children_by_id('sep_bg')[1]
                main_bg = self:get_children_by_id('main_bg')[1]
                bottom_color = self:get_children_by_id('bottom_color')[1]
                
                if(c == awful.client.focus.history.get (c.screen, 0)) then
                   c.lastFocused = true
                else
                   c.lastFocused = false
                end

                if(client.focus == c or c.lastFocused == true) then
                   main_bg.fg = beautiful.fg_focus
                   main_bg.bg = beautiful.bg_focus
                   sep_bg.bg = beautiful.alt_bg_focus
                   sep_bg.fg = config.colors[c.first_tag.index]
                   bottom_color.color = sep_bg.fg
                else
                   main_bg.fg = beautiful.fg_normal
                   main_bg.bg = beautiful.bg_normal
                   sep_bg.bg = beautiful.alt_bg_normal
                   sep_bg.fg = beautiful.alt_fg_normal
                   bottom_color.color = sep_bg.bg
                end

                if(c.minimized) then
                   main_bg.fg = beautiful.fg_minimize
                   main_bg.bg = beautiful.bg_minimize
                   sep_bg.bg = beautiful.alt_bg_minmize
                   sep_bg.fg = beautiful.alt_fg_minimize
                   bottom_color.color = sep_bg.fg
                end
                
                if(#(objects) > 2 or c.screen.index == 2) then
                   class_text.text = c.class
                else
                   class_text.text = c.name
                end
             end,

             update_callback = function(self, c, index, objects)
--                 if (c:isvisible()) then
--                    self:get_children_by_id('class_text')[1].text = c.class
-- --                   self:get_children_by_id('sep_text')[1].visible = false
--                 else
--                    self:get_children_by_id('class_text')[1].text = c.name
--                    --self:get_children_by_id('sep_text')[1].visible = true
                --                 end
                class_text = self:get_children_by_id('class_text')[1]
                sep_text = self:get_children_by_id('sep_text')[1]
                sep_bg = self:get_children_by_id('sep_bg')[1]
                main_bg = self:get_children_by_id('main_bg')[1]
                bottom_color = self:get_children_by_id('bottom_color')[1]
                
                if(c == awful.client.focus.history.get (c.screen, 0)) then
                   c.lastFocused = true
                else
                   c.lastFocused = false
                end

                if(client.focus == c or c.lastFocused == true) then
                   main_bg.fg = beautiful.fg_focus
                   main_bg.bg = beautiful.bg_focus
                   sep_bg.bg = beautiful.alt_bg_focus
                   sep_bg.fg = config.colors[c.first_tag.index]
                   bottom_color.color = sep_bg.fg
                else
                   main_bg.fg = beautiful.fg_normal
                   main_bg.bg = beautiful.bg_normal
                   sep_bg.bg = beautiful.alt_bg_normal
                   sep_bg.fg = beautiful.alt_fg_normal
                   bottom_color.color = sep_bg.fg
                end

                if(c.minimized) then
                   main_bg.fg = beautiful.fg_minimize
                   main_bg.bg = beautiful.bg_minimize
                   sep_bg.bg = beautiful.alt_bg_minmize
                   sep_bg.fg = beautiful.alt_fg_minimize
                   bottom_color.color = beautiful.alt_fg_minimize
                end
                
                if(#(objects) > 2 or c.screen.index == 2) then
                   class_text.text = c.class
                else
                   class_text.text = c.name
                end
             end,
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
    if (s.index == 1) then       -- Main screen
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
    else                        -- Side monitor
        s.mywibox.widget = {
          layout = wibox.layout.align.horizontal,
          { -- Left widgets
             layout = wibox.layout.fixed.horizontal,
             s.mytaglist,
          },
          s.mytasklist -- Middle widget
        }
    end
    



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
