local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local helpers = require("widgets.helpers")
local batteryBar = require("widgets.batteryBar")


sideInfo = {}

-- Create a surface
-- local img = cairo.ImageSurface.create(cairo.Format.ARGB32, 50, 50)

-- Create a context
-- local cr  = cairo.Context(img)

sideInfo.mainClock = wibox.widget{
   widget = wibox.widget.textclock,
   format = "%H:%M",
   refresh = 1,
   font = beautiful.fontname .. " Bold" .. " 40",
   align = "center"
}

sideInfo.altClock = wibox.widget{
   widget = wibox.widget.textclock,
   format = "%A\n%B %d, %Y",
   font = beautiful.fontname .. " Heavy" .. " 15",
   align = "center"
}

sideInfo.lmHomeOnline = wibox.widget{
   {
      widget = wibox.widget.textbox,
      text = "HI",
      align = "center",

   },
   layout = wibox.container.background,
   bg = "#FF0000",
   forced_width = 10,
   forced_height = 20,
   
   shape = gears.shape.rounded_rect
}

sideInfo.wibox = wibox({
            x = 0,
            y = 0,
            width = awful.screen.focused().geometry.width / 6,
            height = awful.screen.focused().geometry.height,
            ontop = true,
            visible = false,

            widget = wibox.widget {
               layout = wibox.container.place,
               valign = "top",
               -- halign = "center",

               {
                  {
                     sideInfo.mainClock,
                     sideInfo.altClock,
--                     wibox.widget.seprator,
                     batteryBar.bat_bar,
                     -- sideInfo.lmHomeOnline,
                     -- sideInfo.volumeDisplay,
                     -- layout = wibox.layout.align.vertical
                     layout = wibox.layout.fixed.vertical
                  },
                  layout = wibox.container.margin,
                  margins = 20

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
