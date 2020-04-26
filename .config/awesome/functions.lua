local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local functions = {}

functions.set_wallpaper = function (s)
   if type(beautiful.wallpaper ) == "function" then
      beautiful.wallpaper = wallpaper(s)
   end
   gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

functions.getOtherScreen = function()
   local curScreen = awful.screen.focused()

   for s in screen do
      if s ~= curScreen then
         return s
      end
   end
end
   

return functions
