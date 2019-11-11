local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local helpers = require("widgets.helpers")

sideInfo = wibox({
            x = 0,
            y = 0,
            width = 300,
            height = awful.screen.focused().geometry.height,
            ontop = true,
            visible = false,

            widget = wibox.widget {
               layout = wibox.container.place,
               valign = "center",

               {
                  {
                     {
                        widget = wibox.widget.textclock,
                        format = "%T",
                        refresh = 1,
                        font = beautiful.fontname .. " Bold" .. " 40",
                        align = "center"
                     },
                     {
                        widget = wibox.widget.textclock,
                        format = "%a %b %d",
                        font = beautiful.fontname .. " Heavy" .. " 20",
                        align = "center"
                     },
                     {
                        id = "volume",
                        widget = wibox.widget.textbox,
                        text = "HELLO"
                     },
                     layout = wibox.layout.align.vertical
                  },
                  layout = wibox.container.margin,
                  margins = 10

               },
            }
})

function sideInfo:toggleVisible()
   self.visible = not self.visible
   self:Update()
end

function sideInfo:Update()

   self.widget.volume.text = "WORKED"


end


return sideInfo
