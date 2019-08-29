local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local menu = require("menu")

--widgets
local volume_control = require("volume-control")

local widgets = {}

widgets.volume = volume_control({})
widgets.sysclock = wibox.widget.textclock("%H:%M")



widgets.taglist = {}

widgets.taglist.spacing = beautiful.taglist_spacing
widgets.taglist.margin = beautiful.taglist_margin

widgets.taglist.widget_template = {
    {
        {
            {
                id = "text_role",
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal
        },
        left  = beautiful.taglist_margin,
        right = beautiful.taglist_margin,

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

widgets.tasklist = {}

widgets.tasklist.spacing = beautiful.tasklist_spacing
widgets.tasklist.widget_template = {
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

widgets.createTaglist = function(s)
	newtaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,

            style = {
                shape = gears.shape.rectangle,
            },

            layout = {
                spacing = menu.taglist.spacing,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = widgets.taglist.widget_template,
    	}
	return newtaglist
end

widgets.createTasklist = function(s)
	newtasklist = awful.widget.tasklist {
            screen   = s,
            filter   = awful.widget.tasklist.filter.currenttags,
            buttons  = tasklist_buttons,

            style = {
                shape_border_width = beautiful.tasklist_bordersize,
                shape  = gears.shape.rectangle,
            },

            layout = {
                spacing = menu.tasklist.spacing,
                layout = wibox.layout.fixed.horizontal
            },
            widget_template = menu.tasklist.widget_template
        }
	return newtasklist
end

return widgets
