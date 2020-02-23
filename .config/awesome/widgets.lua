local wibox = require("wibox")

local widgets = {}

widgets.sysclock = wibox.widget.textclock("%H:%M")

widgets.volume_popup = require("widgets.volume_popup")
widgets.brightness_popup = require("widgets.brightness_popup")

widgets.taglist = require("widgets.taglist")

widgets.tasklist = require("widgets.tasklist")

widgets.sideInfo = require("widgets.sideInfo")

widgets.powerMenu = require("widgets.powerMenu")


return widgets
