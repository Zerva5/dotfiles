local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local functions = require("functions")

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
    shape = gears.shape.rectangle,

    
    create_callback = function(self, t, index, objects)
        if next(t:clients()) == nil then
    	    self.bg = beautiful.taglist_bg_empty
    	    self.fg = beautiful.taglist_fg_empty
        else
            self.bg = beautiful.taglist_bg_normal
    	    self.fg = beautiful.taglist_fg_normal
        end

        if t == awful.screen.focused().selected_tag or t == functions.getOtherScreen().selected_tag then
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

        if t == awful.screen.focused().selected_tag or t == functions.getOtherScreen().selected_tag then
           self.bg = beautiful.taglist_bg_focus
           self.fg = beautiful.taglist_fg_focus
        end

    end
}

-- taglist.create = function(s)
--    newtaglist = {
--       {
--          awful.widget.taglist {
--             screen  = s,
--             filter  = awful.widget.taglist.filter.all,
--             buttons = taglist_buttons,

--             style = {
--                shape = gears.shape.rounded_bar,
--             },

--             layout = {
--                spacing = taglist.spacing,
--                layout = wibox.layout.fixed.horizontal
--             },
--             widget_template = taglist.widget_template,
--          },
--          layout = wibox.container.margin,
--          left = 10,
--          right = 10,
--       },
--       layout = wibox.container.background,
--       shape = gears.shape.rounded_bar,
--       bg = beautiful.taglist_bg
--    }
-- 	return newtaglist
-- end

taglist.create = function(s)

   return wibox{
      visible = true,
      -- ontop = true,
      x = s.geometry.x + s.geometry.width / 6,
      y = 10,
      width = 288,
      -- Each item is 20 wide, spacing of 8px and 8px of padding.
      height = 30,



      widget = wibox.widget{
         layout = wibox.container.background,
         -- bg = "#ffffff",
         {
         layout = wibox.container.margin,
         left = 8,
         right = 8,
         {
         widget = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,

            style = {
               shape = gears.shape.rounded_bar,
            },

            layout = {
               spacing = taglist.spacing,
               layout = wibox.layout.fixed.horizontal
            },
            widget_template = taglist.widget_template,
         },
         },
         },
      }
      --    layout = wibox.container.margin,
      --    left = 10,
      --    right = 10,
      -- },
      -- layout = wibox.container.background,
      -- shape = gears.shape.rectangle,
      -- bg = "#222222"
      -- }
   }

end


return taglist
