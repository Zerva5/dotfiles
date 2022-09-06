local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local config = require("config")


brightness_popup  = {
	popup = awful.popup{
		widget = wibox.widget
		{
			{
				id = "bar",
				max_value = 1,
				value = 0,
				shape = gears.shape.rectangle,
				forced_height = 20, -- 
				forced_width = 100,
--				color = beautiful.volume_bar_fg,
                color = "#fc3948",
                background_color = "#222222",
--				background_color = beautiful.volume_bar_bg,
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
			brightness_popup.popup.visible = false					
		end
	}
}

-- brightness_popup = {
-- 	popup = awful.popup{
-- 		widget = wibox.widget
-- 		{
-- 			{
-- 				id = "bar",
-- 				max_value = 1,
-- 				value = 0,
-- 				shape = gears.shape.rectangle,
-- 				forced_height = 30 * beautiful.scale,
-- 				forced_width = 200 * beautiful.scale,
-- 				-- color = beautiful.brightness_bar_fg,
-- 				-- background_color = beautiful.brightness_bar_bg,
-- 				widget = wibox.widget.progressbar
-- 			},
-- 			widget = wibox.container.rotate,
-- 			direction = "east"

-- 		},
-- 		placement = function(c)
-- 			awful.placement.top_right(c, {margins = beautiful.volume_bar_margin * beautiful.scale})		
-- 		end,
-- 		ontop = true,
-- 		visible = false,
-- 	},

-- 	timer = gears.timer{
-- 		timeout = 1,
-- 		autostart = false,
-- 		single_shot = true,
-- 		callback = function()
-- 			brightness_popup.popup.visible = false					
-- 		end
-- 	}
-- }

function brightness_popup:brightness_down()
	if awesome.hostname  == "LMSPIRE" then
		awful.spawn.easy_async_with_shell("light -U 10 && light", function(out)
			self.popup.widget.bar.value = out / 100
			if self.timer.started == true then
				self.timer:again()
			else
				self.popup.visible = true
				self.timer:start()
			end
		end)

	elseif config.device == "Desktop" then
		awful.spawn.easy_async_with_shell("sh /home/lmayall/dotfiles/Scripts/getBrightness.sh", function(out)
			out = string.gsub(out, "\n", "")
			awful.spawn.easy_async_with_shell("sh /home/lmayall/dotfiles/Scripts/changeBrightness.sh " .. out .. " -10", function() end)
			self.popup.widget.bar.value = (out - 10) / 100
			if self.timer.started == true then
				self.timer:again()
			else
				self.popup.visible = true
				self.timer:start()
			end
		end)
	end
end

function brightness_popup:brightness_up()
	if awesome.hostname == "LMSPIRE" then
		awful.spawn.easy_async_with_shell("light -A 10 && light", function(out)
			self.popup.widget.bar.value = out / 100
			if self.timer.started == true then
				self.timer:again()
			else
				self.popup.visible = true
				self.timer:start()
			end
		end)

	elseif config.device == "Desktop" then
		awful.spawn.easy_async_with_shell("sh /home/lmayall/dotfiles/Scripts/getBrightness.sh", function(out)
			out =  string.gsub(out, "\n", "")
			awful.spawn.easy_async_with_shell("sh /home/lmayall/dotfiles/Scripts/changeBrightness.sh " .. out .. " 10", function(out2)end)

			--naughty.notify({text=(out-10)})

			self.popup.widget.bar.value = (out + 10) / 100
			if self.timer.started == true then
				self.timer:again()
			else
				self.popup.visible = true
				self.timer:start()
			end
		end)
	end

end

return brightness_popup
