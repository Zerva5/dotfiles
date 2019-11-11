local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")

local helpers = {}

function getVolume()
   local vol = "No Update"
   awful.spawn.easy_async_with_shell("pamixer --get-volume", function(out)

   end)
end

helpers.getVolume = getVolume

return helpers
