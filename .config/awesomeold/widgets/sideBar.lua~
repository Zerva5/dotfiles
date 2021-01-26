local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")


brightness_popup = {
	popup = awful.popup{
		widget = wibox.widget
		{
			{
				id = "bar",
				max_value = 1,
				value = 0,
				shape = gears.shape.rectangle,
				forced_height = 15,
				forced_width = 100,
				color = beautiful.brightness_bar_fg,
				background_color = beautiful.brightness_bar_bg,
				widget = wibox.widget.progressbar
			},
			widget = wibox.container.rotate,
			direction = "east"

		},
		placement = function(c)
			awful.placement.top_right(c, {margins = beautiful.brightness_bar_margin})		
		end,
		ontop = true,
		visible = false,
	},

	timer = gears.timer{
		timeout = 1,
		autostart = false,
		single_shot = true,
		callback = function()
			brightness_popup.popup.visible = false					
		end
	}
}

function brightness_popup:brightness_down()
	awful.spawn.easy_async_with_shell("xbacklight -dec 10 -time 100 -steps 10 && xbacklight", function(out)
		self.popup.widget.bar.value = out / 100
		if self.timer.started == true then
			self.timer:again()
		else
			self.popup.visible = true
			self.timer:start()
		end
	end)
end

function brightness_popup:brightness_up()
	awful.spawn.easy_async_with_shell("xbacklight -inc 10 -time 100 -steps 10 && xbacklight", function(out)
		self.popup.widget.bar.value = out / 100
		if self.timer.started == true then
			self.timer:again()
		else
			self.popup.visible = true
			self.timer:start()
		end
	end)
end

return brightness_popup
