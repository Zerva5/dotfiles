local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")


local config = require("config")
local widgets = require("widgets")

local keybinds = {}

keybinds.keyboard = {}

keybinds.mouse = {}

keybinds.keyboard.global = gears.table.join(

   awful.key({ config.modkey}, "`", function()widgets.sideInfo:toggleVisible() end),

    awful.key({ config.modkey, "Control" }, "r", awesome.restart),

    awful.key({config.modkey}, "Return", function() awful.spawn(config.apps.terminal) end),
    awful.key({config.modkey}, "d", function() awful.spawn.with_shell("rofi -show run &") end),

    awful.key({config.modkey}, "l", function() awful.client.focus.byidx(1) end),
    awful.key({config.modkey}, "h", function() awful.client.focus.byidx(-1) end),
    awful.key({config.modkey}, "m", awful.tag.viewnext),
    awful.key({config.modkey}, "n", awful.tag.viewprev),

    awful.key({config.modkey}, "s", function() awful.screen.focus_relative (1) end),

    awful.key({}, "XF86AudioRaiseVolume", function() widgets.volume_popup:volume_up() end),
    awful.key({}, "XF86AudioLowerVolume", function() widgets.volume_popup:volume_down() end),
    awful.key({}, "XF86AudioMute", function() widgets.volume_popup:mute() end),

    awful.key({}, "XF86MonBrightnessUp", function() widgets.brightness_popup:brightness_up() end),
    awful.key({}, "XF86MonBrightnessDown", function() widgets.brightness_popup:brightness_down() end),
    
    awful.key({}, "XF86AudioNext", function() awful.spawn.with_shell("playerctl next") end),
    awful.key({}, "XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous") end),
    awful.key({}, "XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause") end),

    awful.key({config.modkey}, "c", function() naughty.notify({text = "This is a test", title = "Test"})end), 

    awful.key({ config.modkey, "Shift" }, "n", function ()
        if client.focus then
            local tagIndex = (client.focus.first_tag.index - 2) % 10 + 1
            local tag = client.focus.screen.tags[tagIndex]
            if tag then
                client.focus:move_to_tag(tag)
        	awful.tag.viewprev()
            end
        end
    end),
    awful.key({ config.modkey, "Shift" }, "m", function ()
        if client.focus then
            local tagIndex = (client.focus.first_tag.index) % 10 + 1
            local tag = client.focus.screen.tags[tagIndex]
            if tag then
                client.focus:move_to_tag(tag)
        	awful.tag.viewnext()
            end
        end
    end),

    awful.key({config.modkey, "Shift"}, "k", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:emit_signal(
              "request::activate", "key.unminimize", {raise = true}
         )
        end
    end)
    --awful.key({config.modkey}, ),
)

for i = 1, 10 do
    keybinds.keyboard.global = gears.table.join(keybinds.keyboard.global,
        -- View tag only.
        awful.key({ config.modkey }, "#" .. i + 9,
                    function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            tag:view_only()
                        end
                    end,
                    {description = "view tag #"..i, group = "tag"}),
       -- Move client to tag.
        awful.key({ config.modkey, "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end,
                    {description = "move focused client to tag #"..i, group = "tag"})
   )
    end


keybinds.keyboard.client = gears.table.join(
    awful.key({config.modkey}, "q", function(c) c:kill() end),

    awful.key({}, "F11", function(c) 
	c.fullscreen = not c.fullscreen
	c:raise()
    end),

    awful.key({config.modkey}, "k", function(c) c.minimized = true end),

    awful.key({config.modkey}, "f", function(c) awful.client.floating.toggle(c) end),

    awful.key({ config.modkey, "Shift" }, "s", function(c) 
	    local oldtag = c.first_tag.index

	    c:move_to_screen ()

	    local newtags = awful.screen.focused().tags

	    c:move_to_tag(newtags[oldtag])


    end)

)

keybinds.mouse.client = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ config.modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ config.modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

keybinds.mouse.taglist = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end)
)

keybinds.mouse.tasklist = gears.table.join(
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
        end)
)


return keybinds
