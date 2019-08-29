local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")


volume_popup = {
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
				color = beautiful.volume_bar_fg,
				background_color = beautiful.volume_bar_bg,
				widget = wibox.widget.progressbar
			},
			widget = wibox.container.rotate,
			direction = "east"

		},
		placement = function(c)
			awful.placement.top_right(c, {margins = beautiful.volume_bar_margin})		
		end,
		ontop = true,
		visible = false,
	},

	timer = gears.timer{
		timeout = 1,
		autostart = false,
		single_shot = true,
		callback = function()
			volume_popup.popup.visible = false					
		end
	}
}

function volume_popup:volume_down()
	awful.spawn.easy_async_with_shell("pamixer -d 5 && pamixer --get-volume", function(out)
		self.popup.widget.bar.value = out / 100
		if self.timer.started == true then
			self.timer:again()
		else
			self.popup.visible = true
			self.timer:start()
		end
	end)
end

function volume_popup:volume_up()
	awful.spawn.easy_async_with_shell("pamixer -i 5 && pamixer --get-volume", function(out)
		self.popup.widget.bar.value = out / 100
		if self.timer.started == true then
			self.timer:again()
		else
			self.popup.visible = true
			self.timer:start()
		end
	end)
end

return volume_popup
