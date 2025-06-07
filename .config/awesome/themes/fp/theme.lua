----------------------------------------------------------
-- Default awesome theme ---------------------------------
----------------------------------------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = {}

--theme.font          = "Sans                Regular 10"
--theme.font          = "ConsolaMono                Regular 10"
theme.font          = "FantasqueSansMNerdFont     Regular 14"
--theme.font          = "FiraCode Nerd Font         SemiBold 8"
--theme.font          = "GohuFont11NerdFont         Regular 12"
--theme.font          = "InconsolataNerdFont        Regular 12"
--theme.font          = "Iosevka Nerd Font          Regular 10"
--theme.font          = "IosevkaTerm Nerd Font      Regular 10"
--theme.font          = "JetBrainsMono Nerd Font    Bold 10"
--theme.font          = "Maple Mono NF              Regular 8"
--theme.font          = "mononoki                   Regular 10"
--theme.font          = "NovaMono                   Regular 10"
--theme.font          = "Unifont           Regular 12"
--theme.font          = "3270NerdFont           Regular 12"
--theme.font          = "ProggyClean CE Nerd Font   Regular 12"
--theme.font          = "UbuntuSans Nerd Font       SemiBold 10"
--theme.font          = "VictorMono Bold                  10"
--theme.font          = "ZedmonoNerdFontMono        Bold 10"
--theme.font          = "Font Awesome 6 Brands Regular 6"

----------------------------------------------------------
---------------BARRA--------------------------------------
----------------------------------------------------------
--theme.bg_normal     = "#2C2C2CAF"  --Orchis-dark

--theme.bg_normal     = "#00000000"
theme.bg_normal = "#1F2329" --igual kitty
--theme.bg_normal  = "#644540"
--theme.bg_normal  = "#1B443C"
--theme.bg_normal  = "#282C34" --onedark
--theme.bg_normal  = "#1C2529"
--theme.bg_normal  = "#222222" -- PADRAO
--theme.bg_normal     = "#263238" -- material blue-gray
--theme.bg_normal     = "#263238EF" -- material blue-gray
--theme.bg_normal     = "#282828F" --gruvbox
--theme.bg_normal     = "#263238"
--theme.bg_normal     = "#171f24" --color wallpaper_green
--theme.bg_normal     = "#1a1b26" --TokyoNight
--theme.bg_normal     = "#3b4252" --nord
--theme.bg_normal     = "#2B2E3B" --light1 nord
--theme.bg_normal     = "#2e3440" --light nord
--theme.bg_normal     = "#2b2e3b" --dark nord
--theme.bg_normal     = "#27383a" --light green
--theme.bg_normal     = "#111d20" --dark green
--theme.bg_normal     = "#1b2523" --green
--theme.bg_normal     = "#2E1643"
--theme.bg_normal     = "#864087"
--theme.bg_normal     = "#060817"
--theme.bg_normal     = "#000000"
---------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--TAGLISTCOLOR
--theme.bg_focus      = "#8a8ea8" -- #e9befb" --"#db93f9" --"#535d6c"
--theme.bg_focus = "#282c340F"
--theme.bg_focus = "#ffffff00"
--theme.bg_focus      = "#535d6c"
theme.bg_focus      = "#1F2329"
--theme.bg_focus      = "#2b2e3b"


theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#000000"
--theme.bg_minimize = "#444444"

--theme.bg_systray    = theme.bg_normal
--theme.bg_systray    = "#0000001F"
--theme.bg_systray = theme.bg_normal


--COLOR DOT
--theme.fg_normal1 = "#88c0d0"
theme.fg_normal1 = "#ff5555"
theme.fg_normal11 = "#ffffff8F"
theme.fg_normal111 = "#ffffff00"
--theme.fg_normal1 = "#FFFFFF"
----------------------------------------------------------
------------COLOR-FONT------------------------------------
----------------------------------------------------------
--theme.fg_normal     = "#aaaaaa" --standard
theme.fg_normal = "#ffffff"
--theme.fg_normal     = "#ffffffCF"
--theme.fg_normal     = "#000000"
--theme.fg_normal     = "#CFD2C6"



----------------------------------------------------------
----------------------------------------------------------
--theme.fg_focus = "#ffffff" --standard
--theme.fg_focus      = "#000000"
theme.fg_focus      = "#ff5555"
--theme.fg_focus      = "#b4f9f8"
--theme.fg_focus      = "#88c0d0"

----------------------------------------------------------
----------------------------------------------------------
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

----------------------------------------------------------
----------------------------------------------------------
theme.useless_gap = dpi(0)
theme.border_width = dpi(1)

--BORDA DAS JANELAS
--theme.border_normal  = "#848487" -- Gray
--theme.border_normal = "#535d6F"
theme.border_normal = "#0000000F"




-- BORDA FOCUS
--theme.border_focus  = "#88c0d0"
theme.border_focus = "#848487" -- Gray

--theme.border_focus = "#7ACCD7"
--theme.border_focus  = "#535d6F" -- PADRAO
--theme.border_focus  = "#31C0F6"--dracula
--theme.border_focus  = "#b4f9f8" --TokyoNight
--theme.border_focus  = "#52C647"-- Dracula green
--theme.border_focus  = "#FF79C6" --dracula
--theme.border_focus  = "#00C4F0"
---------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
--theme.border_marked = "#91231c"
theme.border_marked = "#91231c" --TokyoNight
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

------ Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal11)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal11)

---- Generate taglist squares:
--local taglist_square_size = dpi(10)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal1)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)








-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

--You can add as many variables as
--you wish and access them by using
--beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

--Define the image to load
--theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
--theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_close_button_focus  = themes_path.."default/titlebar/5.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inact.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"



theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

--theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
--theme.awesome_icon = theme_assets.awesome_icon(
--    theme.menu_height, theme.bg_focus, theme.fg_focus
--    --theme.icon_theme = "/home/filipe/Downloads/awe.png"
--)

theme.awesome_icon = "/home/filipe/.dotfiles/.config/others/icons/linux.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
