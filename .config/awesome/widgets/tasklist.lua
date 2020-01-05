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
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
                --id = "task_name",
                --widget = wibox.widget.textbox,
            },
            id = "iconBar",
            bottom = 2,
            widget = wibox.container.margin,

        },
        layout = wibox.layout.fixed.horizontal
        },
        left  = 10,
        right = 10,
        widget = wibox.container.margin
    },
    widget = wibox.container.background,

    create_callback = function(self, c, index, objects)
        icon = self:get_children_by_id("clienticon")[1]
        iconBar = self:get_children_by_id("iconBar")[1]
        icon.client = c

        if c == client.focus then
            iconBar.color = beautiful.black
            icon.opacity = 1
        elseif c.minimized == true then
            icon.opacity = 0.5
            iconBar.color = beautiful.black .. "55"
        elseif c ~= client.focus then
            icon.opacity = 1
            iconBar.color = beautiful.black .. "55"
        end
    --    self:get_children_by_id("task_name")[1].text = c.name
    --    if c == client.focus then
    --        self.fg = beautiful.tasklist_fg_focus
	--    self.bg = beautiful.tasklist_bg_focus
	--elseif c.minimized == true then
	--    self.bg = beautiful.tasklist_bg_empty
	--    self.fg = beautiful.tasklist_fg_empty
    --    elseif c ~= client.focus then
    --        self.fg = beautiful.tasklist_fg_normal
	--    self.bg = beautiful.tasklist_bg_normal
    --    end
    end,
    update_callback = function(self, c, index, objects)
        icon = self:get_children_by_id("clienticon")[1]
        iconBar = self:get_children_by_id("iconBar")[1]
        icon.client = c

        if c == client.focus then
            iconBar.color = beautiful.black
            icon.opacity = 1
        elseif c.minimized == true then
            icon.opacity = 0.2
            iconBar.color = beautiful.black .. "55"
        elseif c ~= client.focus then
            icon.opacity = 1
            iconBar.color = beautiful.black .. "55"
        end
    --    self:get_children_by_id("task_name")[1].text = c.name
    --
    --    if c == client.focus then
    --        self.fg = beautiful.tasklist_fg_focus
	--    self.bg = beautiful.tasklist_bg_focus
	--elseif c.minimized == true then
	--    self.bg = beautiful.tasklist_bg_empty
	--    self.fg = beautiful.tasklist_fg_empty
    --    elseif c ~= client.focus then
    --        self.fg = beautiful.tasklist_fg_normal
	--    self.bg = beautiful.tasklist_bg_normal
    --    end
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
