---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "/home/lmayall/dotfiles/awesome/"

local theme = {}

theme.font          = "Source Code Pro Bold 10"
theme.opacity       = "FF"

theme.bg_normal     = "#3f4953" .. theme.opacity
theme.bg_focus      = "#f9c8a8" .. theme.opacity
theme.bg_urgent     = "#ecccbc" .. theme.opacity
theme.bg_minimize   = "#b4a1a5" .. theme.opacity
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#dba687"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(3)
theme.border_normal = "#3f4953"
theme.border_focus  = "#dba687"
theme.border_marked = "#ecccbc"

theme.bar_position = "top"

theme.taglist_bg_focus = "#dba687"
theme.taglist_bg_empty = "#3f4953" .. theme.opacity
theme.taglist_bg_normal = "#566977" .. theme.opacity

theme.taglist_fg_focus = "#3f4953"
theme.taglist_fg_empty = "#dba687"
theme.taglist_fg_normal = "#dba687"

theme.taglist_bordercolor = ""
theme.taglist_bordersize = 0
theme.taglist_spacing = 0
theme.taglist_margin = 10

theme.tasklist_bg_focus = theme.taglist_bg_focus
theme.tasklist_bg_empty = theme.taglist_bg_empty
theme.tasklist_bg_normal = theme.taglist_bg_normal

theme.tasklist_fg_focus = theme.taglist_fg_focus
theme.tasklist_fg_empty = "#566977"
theme.tasklist_fg_normal = theme.taglist_fg_normal

theme.tasklist_bordercolor = ""
theme.tasklist_bordersize = 0
theme.tasklist_spacing = 0
theme.tasklist_margin = 20

theme.rightmenu_fg = theme.taglist_fg_empty
theme.rightmenu_bg = theme.taglist_bg_empty
theme.rightmenu_border = ""
theme.rightmenu_bordersize = 0

theme.rightmenu_spacing = 10

theme.notification_bg = theme.taglist_bg_empty

theme.volume_bar_bg = theme.taglist_bg_empty
theme.volume_bar_fg = theme.taglist_bg_focus
theme.volume_bar_margin = 30




-- There are other variable sets
-- overriding the wind one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:


-- theme.taglist.fg_normal = theme.fg_normal
-- theme.taglist.fg_focus = theme.fg_focus
-- theme.taglist.fg_empty = "#113311"


-- Generate taglist squares:
-- local taglist_square_size = dpi(2)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."wind/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."wind/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."wind/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."wind/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."wind/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."wind/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."wind/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."wind/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."wind/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."wind/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."wind/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."wind/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."wind/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."wind/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."wind/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."wind/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."wind/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."wind/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."wind/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."wind/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."wind/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."/wind/background"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."wind/layouts/fairhw.png"
theme.layout_fairv = themes_path.."wind/layouts/fairvw.png"
theme.layout_floating  = themes_path.."wind/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."wind/layouts/magnifierw.png"
theme.layout_max = themes_path.."wind/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."wind/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."wind/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."wind/layouts/tileleftw.png"
theme.layout_tile = themes_path.."wind/layouts/tilew.png"
theme.layout_tiletop = themes_path.."wind/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."wind/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."wind/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."wind/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."wind/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."wind/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."wind/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
--
