local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")


local menu = {}
menu.taglist = {}

menu.taglist.spacing = beautiful.taglist_spacing
menu.taglist.margin = beautiful.taglist_margin

menu.taglist.widget_template = {
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

menu.tasklist = {}

menu.tasklist.spacing = beautiful.tasklist_spacing

menu.tasklist.widget_template = {
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

menu.widgets = {}


return menu
