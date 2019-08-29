local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local taglist = {}

taglist.spacing = beautiful.taglist_spacing
taglist.margin = beautiful.taglist_margin

taglist.widget_template = {
    {
        {
            {
                id = "text_role",
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal
        },
        left  = taglist.margin,
        right = taglist.margin,

        widget = wibox.container.margin
    },
    widget = wibox.container.background,

    
    create_callback = function(self, t, index, objects)
        if next(t:clients()) == nil then
    	    self.bg = beautiful.taglist_bg_empty
    	    self.fg = beautiful.taglist_fg_empty
        else
            self.bg = beautiful.taglist_bg_normal
    	    self.fg = beautiful.taglist_fg_normal
        end

        if t == awful.screen.focused().selected_tag then
    	    self.bg = beautiful.taglist_bg_focus
    	    self.fg = beautiful.taglist_fg_focus
        end
    end,

    update_callback = function(self, t, index, objects)
        if next(t:clients()) == nil then
    	self.bg = beautiful.taglist_bg_empty
    	self.fg = beautiful.taglist_fg_empty
        else
            self.bg = beautiful.taglist_bg_normal
    	self.fg = beautiful.taglist_fg_normal
        end

        if t == awful.screen.focused().selected_tag then
    	    self.bg = beautiful.taglist_bg_focus
    	    self.fg = beautiful.taglist_fg_focus
        end

    end
}

taglist.create = function(s)
	newtaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,

            style = {
                shape = gears.shape.rectangle,
            },

            layout = {
                spacing = taglist.spacing,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = taglist.widget_template,
    	}
	return newtaglist
end


return taglist
