local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local tasklist = {}

tasklist.spacing = beautiful.tasklist_spacing

tasklist.widget_template = {
{
    {
        {
            id = "task_name",
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal
        },
        left  = 10,
        right = 10,
        widget = wibox.container.margin
    },
    widget = wibox.container.background,

    create_callback = function(self, c, index, objects)
        self:get_children_by_id("task_name")[1].text = c.class
        if c == client.focus then
            self.fg = beautiful.tasklist_fg_focus
	    self.bg = beautiful.tasklist_bg_focus
	elseif c.minimized == true then
	    self.bg = beautiful.tasklist_bg_empty
	    self.fg = beautiful.tasklist_fg_empty
        elseif c ~= client.focus then
            self.fg = beautiful.tasklist_fg_normal
	    self.bg = beautiful.tasklist_bg_normal
        end
    end,
    update_callback = function(self, c, index, objects)
        self:get_children_by_id("task_name")[1].text = c.class

        if c == client.focus then
            self.fg = beautiful.tasklist_fg_focus
	    self.bg = beautiful.tasklist_bg_focus
	elseif c.minimized == true then
	    self.bg = beautiful.tasklist_bg_empty
	    self.fg = beautiful.tasklist_fg_empty
        elseif c ~= client.focus then
            self.fg = beautiful.tasklist_fg_normal
	    self.bg = beautiful.tasklist_bg_normal
        end
    end,
}

tasklist.create = function(s)
	newtasklist = awful.widget.tasklist {
            screen   = s,
            filter   = awful.widget.tasklist.filter.currenttags,
            buttons  = tasklist_buttons,

            style = {
                shape_border_width = beautiful.tasklist_bordersize,
                shape  = gears.shape.rectangle,
            },

            layout = {
                spacing = tasklist.spacing,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = tasklist.widget_template
        }
	return newtasklist
end


return tasklist
