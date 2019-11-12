local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local helpers = require("widgets.helpers")

sideInfo = {}

sideInfo.mainClock = wibox.widget{
   widget = wibox.widget.textclock,
   format = "%T",
   refresh = 1,
   font = beautiful.fontname .. " Bold" .. " 40",
   align = "center"
}

sideInfo.altClock = wibox.widget{
   widget = wibox.widget.textclock,
   format = "%a %b %d",
   font = beautiful.fontname .. " Heavy" .. " 20",
   align = "center"
}

sideInfo.volumeDisplay = wibox.widget{
   widget = wibox.widget.textbox,
   text = "110%",
   align = "center"
}


sideInfo.wibox = wibox({
            x = 0,
            y = 0,
            width = 300,
            height = awful.screen.focused().geometry.height,
            ontop = true,
            visible = false,

            widget = wibox.widget {
               layout = wibox.container.place,
               valign = "top",
               halign = "center",

               {
                  {
                     sideInfo.mainClock,
                     sideInfo.altClock,
                     sideInfo.volumeDisplay,
                     layout = wibox.layout.align.vertical
                  },
                  layout = wibox.container.margin,
                  margins = 10

               },
            }
})



function sideInfo:toggleVisible()
   self.wibox.visible = not self.wibox.visible
   -- sideInfo:Update()
end

function sideInfo:Update()
   awful.spawn.easy_async_with_shell("pamixer --get-volume", function(out)
                                        sideInfo.volumeDisplay.text = tonumber(out) .. "%"
   end)
end


return sideInfo
