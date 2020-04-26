local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local tasklist = {}

tasklist.spacing = beautiful.tasklist_spacing

tasklist.widget_template = {
   {
      {
         {
            {
               id = "task_name",
               widget = wibox.widget.textbox,
            },
            id = "bottomBar",
            bottom = beautiful.tasklist_bordersize,
            widget = wibox.container.margin,
         },
         layout = wibox.layout.fixed.horizontal

      },
      -- margins = beautiful.tasklist_bordersize,
      -- left = 20,
      -- right = 20,
      -- bottom = 5,
      -- top = 5,
      -- margins = 0,
      -- color = "#ffffff",
      widget = wibox.container.margin
   },
   widget = wibox.container.background,
   shape = gears.shape.rounded_bar,
   

    create_callback = function(self, c, index, objects)
        -- icon = self:get_children_by_id("clienticon")[1]
        -- iconBar = self:get_children_by_id("iconBar")[1]
        -- icon.client = c

        -- if c == client.focus then
            -- iconBar.color = beautiful.black
            -- icon.opacity = 1
        -- elseif c.minimized == true then
            -- icon.opacity = 0.5
            -- iconBar.color = beautiful.black .. "55"
        -- elseif c ~= client.focus then
            -- icon.opacity = 1
            -- iconBar.color = beautiful.black .. "55"
        -- end
       self:get_children_by_id("task_name")[1].text = c.class

       bottomBar = self:get_children_by_id("bottomBar")[1]
       if c == client.focus then
           self.fg = beautiful.tasklist_fg_focus
	   self.bg = beautiful.tasklist_bg_focus
	   bottomBar.color = beautiful.tasklist_bordercolor_focus
	elseif c.minimized == true then
	   self.bg = beautiful.tasklist_bg_empty
	   self.fg = beautiful.tasklist_fg_empty
	   bottomBar.color = beautiful.tasklist_bordercolor_empty
       elseif c ~= client.focus then
           self.fg = beautiful.tasklist_fg_normal
	   self.bg = beautiful.tasklist_bg_normal
	   bottomBar.color = beautiful.tasklist_bordercolor_normal
       end
    end,
    update_callback = function(self, c, index, objects)
        -- icon = self:get_children_by_id("clienticon")[1]
        -- iconBar = self:get_children_by_id("iconBar")[1]
        -- icon.client = c

        -- if c == client.focus then
            -- iconBar.color = beautiful.black
            -- icon.opacity = 1
        -- elseif c.minimized == true then
            -- icon.opacity = 0.2
            -- iconBar.color = beautiful.black .. "55"
        -- elseif c ~= client.focus then
            -- icon.opacity = 1
            -- iconBar.color = beautiful.black .. "55"
       -- end
       self:get_children_by_id("task_name")[1].text = c.class

       bottomBar = self:get_children_by_id("bottomBar")[1]
       
       if c == client.focus then
          self.fg = beautiful.tasklist_fg_focus
          self.bg = beautiful.tasklist_bg_focus
          -- bottomBar.color = beautiful.tasklist_bordercolor_focus
       elseif c.minimized == true then
          self.bg = beautiful.tasklist_bg_empty
          self.fg = beautiful.tasklist_fg_empty
          -- bottomBar.color = beautiful.tasklist_bordercolor_empty
       else
          self.fg = beautiful.tasklist_fg_normal
          self.bg = beautiful.tasklist_bg_normal
          -- bottomBar.color = beautiful.tasklist_bordercolor_normal
       end
    end,
}

tasklist.create = function(s)
   return wibox{
      visible = true,
      -- ontop = true,
      width = 400,
      x = s.geometry.x + (s.geometry.width / 2) - 200,
      y = 10,

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
               layout = wibox.container.place,
               halign = "center",
               {
                  widget = awful.widget.tasklist {
                     screen   = s,
                     filter   = awful.widget.tasklist.filter.currenttags,
                     buttons  = tasklist_buttons,

                     style = {
                        shape_border_width = beautiful.tasklist_bordersize,
                        shape  = gears.shape.rectangle,
                     },
                     
                     layout = {
                        spacing = beautiful.tasklist_spacing,
                        layout = wibox.layout.fixed.horizontal
                     },
                     widget_template = tasklist.widget_template,
                  },
               },
            }
         },
      }

      -- widget = newtasklist = {
      -- {
      --    awful.widget.tasklist {
      --          screen   = s,
      --          filter   = awful.widget.tasklist.filter.currenttags,
      --          buttons  = tasklist_buttons,

      --          style = {
      --             shape_border_width = beautiful.tasklist_bordersize,
      --             shape  = gears.shape.rectangle,
      --          },

      --          layout = {
      --             spacing = tasklist.spacing,
      --             layout = wibox.layout.fixed.horizontal
      --          },
      --          widget_template = tasklist.widget_template,
      --       },
      --       layout = wibox.container.margin,
      --       -- left = 10,
      --       -- right = 10,
      --    },
      --    layout = wibox.container.background,
      --    shape = gears.shape.rounded_bar,
      --    bg = beautiful.taglist_bg,
      -- }

   }

end


return tasklist
