---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = "/home/lmayall/dotfiles/.config/awesome/"

local theme = {}
--theme.opacity = {}

theme.fontname = "Iosevka"
theme.fontsize = "11"
theme.fontweight = "Normal"

theme.iconFont = "FontAwesome5Free-Regular"
theme.iconSize = "12"
theme.iconWeight = "Solid"

theme.white = "#c1c8b6"
theme.black = "#18222e"
theme.light = "#AAAAAA"
theme.dark = "#888888"
theme.color = "#3C4E59"

theme.highOpacity = "99"
theme.mediumOpacity = "55"
theme.lowOpacity = "11"
theme.transparent = "00"
theme.opaque = "ff"

theme.font          = "Iosevka Medium 13"

theme.bg_normal     = "#18222e"

theme.bg_focus      = theme.color
theme.bg_urgent     = "#ecccbc"
theme.bg_minimize   = "#b4a1a5"
theme.bg_systray    = "#18222e"

theme.fg_normal     = "#d82d51"
theme.fg_focus      = theme.white
theme.fg_urgent     = theme.light
theme.fg_minimize   = theme.white

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(1)
theme.border_normal = "#00000000"
-- theme.border_focus  = "#3f0d1800"
theme.border_focus  = "#d82d5100"
-- theme.border_focus = "#ffffff"
theme.border_marked = "#ecccbc00"

theme.bar_position = "top"
theme.bar_width = 1000
theme.bar_height = 30
--theme.wibar_border_width = 20
--theme.wibar_border_color = "#ffffff00"

theme.taglist_bg_focus = "#d82d51"
theme.taglist_bg_empty = "#18222e"
theme.taglist_bg_normal = "#18222e"

theme.taglist_fg_focus = "#c1c8b6"
theme.taglist_fg_normal = "#c1c8b6"
theme.taglist_fg_empty = "#484f55"

theme.taglist_bordercolor =  "#c1c8b6"
theme.taglist_bordersize = 0
theme.taglist_spacing = 0
theme.taglist_margin = 8


-- Unused, I use icons now not text for the tasklist
theme.tasklist_bg_focus = "#18222e"
theme.tasklist_bg_empty = "#18222e"
theme.tasklist_bg_normal = "#18222e"

theme.tasklist_fg_focus = "#d82d51"
theme.tasklist_fg_empty = "#484f55"
theme.tasklist_fg_normal = "#d82d51"

theme.tasklist_bordercolor_focus = "#d82d51"
theme.tasklist_bordercolor_empty = "#18222e"
theme.tasklist_bordercolor_normal = "#484f55"
theme.tasklist_bordersize = 2
theme.tasklist_spacing = 5
theme.tasklist_margin = 40

-- End of unused

theme.rightmenu_fg = "#d82d51"
theme.rightmenu_bg = theme.taglist_bg_empty
theme.rightmenu_border = ""
theme.rightmenu_bordersize = 0

theme.rightmenu_spacing = 10

theme.notification_bg = theme.dark .. theme.lowOpacity

theme.volume_bar_bg = theme.dark .. theme.lowOpacity
theme.volume_bar_fg = "#fc3948"
-- theme.volume_bar_fg = theme.color
theme.volume_bar_margin = 20
theme.volume_bar_mute = "#fc394888"

theme.brightness_bar_bg = theme.dark .. theme.lowOpacity
theme.brightness_bar_fg = "#1af2fe88"
theme.brightness_bar_margin = 20

theme.SIcpuUsage_bg = "#000000ff"
theme.SIcpuUsage_fg_normal = "#ffffff"
theme.SIcpuUsage_fg_medium = "#ffc147"
theme.SIcpuUsage_fg_high = "#ff4c4c"

theme.batteryIcon = {"", "", "", "", ""}




-- There are other variable sets
-- overriding the delorean one when
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
theme.notification_fg = theme.white
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_border_width = 0
theme.notification_border_color = ""
theme.notification_margin = 50
-- theme.notification_width = 6

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."delorean/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."subway/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."subway/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."subway/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."subway/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."subway/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."subway/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."subway/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."subway/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."subway/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."subway/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."subway/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."subway/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."subway/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."subway/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."subway/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."subway/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."subway/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."subway/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."subway/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."subway/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path.."/subway/background"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."subway/layouts/fairhw.png"
theme.layout_fairv = themes_path.."subway/layouts/fairvw.png"
theme.layout_floating  = themes_path.."subway/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."subway/layouts/magnifierw.png"
theme.layout_max = themes_path.."subway/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."subway/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."subway/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."subway/layouts/tileleftw.png"
theme.layout_tile = themes_path.."subway/layouts/tilew.png"
theme.layout_tiletop = themes_path.."subway/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."subway/layouts/spiralw.png"
theme.layout_dsubwayle = themes_path.."subway/layouts/dsubwaylew.png"
theme.layout_cornernw = themes_path.."subway/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."subway/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."subway/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."subway/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
--

