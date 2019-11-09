local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")


sideInfo = wibox({
      x = 0,
      y = 0,
      width = 300,
      height = 1080,
      ontop = true,
      visible = false,

      widget = wibox.widget {
         {
            {
               {
                  max_value = 1,
                  value = 0.5,
                  forced_height = 100,
                  forced_width = 20,
                  widget = wibox.widget.progressbar
               },
               direction = "east",
               layout = wibox.container.rotate
            },
            {
               widget = wibox.widget.textbox,
               text = "hello!"
            },
            layout = wibox.layout.fixed.vertical
         },
         widget = wibox.container.background

         
      }



})

function sideInfo:toggleVisible()
   self.visible = not self.visible   
end

return sideInfo
