local wibox = require("wibox")

local widgets = {}

widgets.sysclock = wibox.widget.textclock("%H:%M")

widgets.volume_popup = require("widgets.volume_popup")

widgets.taglist = require("widgets.taglist")

widgets.tasklist = require("widgets.tasklist")


return widgets
