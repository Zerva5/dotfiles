local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local config = require("config")


batteryBar = {
   bat_bar = wibox.widget{
      {
	 
	 widget = wibox.widget.textbox,
	 text = "10%",
	 -- align = "center",
	 id = "text"

      },
      layout = wibox.container.margin,
      -- top = 40,
      -- left = 15,
      -- right = 15,
   },
   timer = gears.timer{
      timeout = 5,
      autostart = true,
      single_shot = false,
      callback = function()
	 awful.spawn.easy_async_with_shell("sh ~/dotfiles/Scripts/Laptop/batteryLevel.sh", function(out)
                          -- naughty.notify{text=out}
					      local result = string.gsub(out, "\n", "")
					      local index = 1
					      
					      if (tonumber(result) < 20) then
						 index = 1
					      elseif (tonumber(result) < 40) then
						 index = 2
					      elseif (tonumber(result) < 60) then
						 index = 3
					      elseif (tonumber(result) < 80) then
						 index = 4
					      elseif (tonumber(result) < 100) then
						 index = 5
					      end
					      
					      -- batteryBar.bat_bar:get_children_by_id("text")[1].text = beautiful.batteryIcon[index] .. " " .. result .. "%"
    					  batteryBar.bat_bar:get_children_by_id("text")[1].text = result .. "%"

	 end)
    
      end,
    -- timeout = 100,
    
   }
}

return batteryBar
