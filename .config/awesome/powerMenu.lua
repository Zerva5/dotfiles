local awful = require("../awful")
local beautiful = require("../beautiful")
local wibox = require("../wibox")
local gears = require("gears")
local naughty = require("naughty")
local config = require("config")
-- local root = require("root")

powerMenu = {}

powerMenu.off = wibox.widget{
   widget = wibox.widget.textbox,
   text = "(P)ower Off",
   align = "center",
   valign = "center"
}

powerMenu.logout = wibox.widget{
   widget = wibox.widget.textbox,
   text = "(L)og Out",
   align = "center",
   valign = "center"
}

powerMenu.restart = wibox.widget{
   widget = wibox.widget.textbox,
   text = "(R)estart",
   align = "center",
   valign = "center"
}

powerMenu.wibox = wibox({
            -- width = awful.screen.focused().geometry.width / 6,
            -- height = awful.screen.focused().geometry.height,
	    width = 400 * config.scaling,
            height = 40 * config.scaling,
	    x = (awful.screen.focused().geometry.width / 2) - (200 * config.scaling),
            y = (awful.screen.focused().geometry.height / 2) - (20 * config.scaling),
            ontop = true,
            visible = false,

            widget = wibox.widget {
                              
               
	       {
		  powerMenu.logout,
		  powerMenu.off,
		  powerMenu.restart,
		  layout = wibox.layout.align.horizontal,
		  -- layout = wibox.container.margin,

	       },
	       layout = wibox.container.margin,
	       left = 30,
	       right = 30,

	    },
})


function powerMenu:toggleVisible()
   self.wibox.visible = not self.wibox.visible
end

function powerMenu:off()
   root.fake_input('key_press', 112)
   root.fake_input('key_release', 112)
   if(self.wibox.visible) then
      awful.spawn.easy_async_with_shell("shutdown now")
   end
end



function powerMenu:logout()
   if(self.wibox.visible) then
      awesome.quit()
   end
end

function powerMenu:restart()
   if(self.wibox.visible) then
      awful.spawn.easy_async_with_shell("reboot")
   end
end
return powerMenu
