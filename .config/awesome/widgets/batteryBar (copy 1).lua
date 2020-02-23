local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local config = require("config")


batteryBar = {
   bat_bar = wibox.widget{
      {
	 
	 {
	    widget = wibox.widget.textbox,
	    font = "FontAwesome5Free-Regular Solid 12",
	    text = "",
	    align = "center",
	    id = "text"
	 },
	 {
	    max_value = 10,
	    value = 5,
	    id = "bar",
	    forced_height = 15,
	    color = beautiful.SIbatUsage_fg,
	    background_color = beautiful.SIbatUsage_bg,
	    widget = wibox.widget.progressbar
	 },
	 layout = wibox.layout.align.vertical
      },
      layout  = wibox.container.margin,
      top = 40,
      left = 15,
      right = 15,
   },
   timer = gears.timer{
      timeout = 5,
      autostart = true,
      single_shot = false,
      callback = function()
	 awful.spawn.easy_async_with_shell("sh ~/dotfiles/Scripts/Laptop/batteryLevel.sh", function(out)
					      local result = string.gsub(out, "\n", "")
					      batteryBar.bat_bar:get_children_by_id("bar")[1].value = result / 10
					      batteryBar.bat_bar:get_children_by_id("text")[1].text = result .. "%"

	 end)
      end
   }
}

return batteryBar
