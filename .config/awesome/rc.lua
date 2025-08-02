pcall(require, "luarocks.loader")

----------------------------------------------------------------------
---------------------------- LIBRARIES -------------------------------
----------------------------------------------------------------------
local gears = require("gears")
local awful = require("awful")
              require("awful.autofocus")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local has_fdo, freedesktop = pcall(require, "freedesktop")
local beautiful = require("beautiful")
local corner_radius = 4000
local lain = require("lain")
local vicious = require("vicious")
local debian = require("debian.menu")
local color = require("gears.color")
local watch = require("awful.widget.watch")

-- Inicialize a temperatura com um valor padrão
local current_temp = 6500  -- Temperatura inicial (valor padrão)
local step_temp = 100      -- Incremento/decremento (mais suave)
----------------------------------------------------------------------
---------------------------- THEMES ----------------------------------
----------------------------------------------------------------------
--beautiful.init(gears.filesystem.get_themes_dir() .. "fp/theme.lua")
--beautiful.init(gears.filesystem.get_themes_dir() .. "Nord/theme.lua")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/fp/theme.lua")


----------------------------------------------------------------------
---------------------------- MODE_FLOATING ---------------------------
----------------------------------------------------------------------

client.connect_signal("manage", function (c)
    -- Apps específicos que devem ser flutuantes
    local float_instances = {
        --kitty = true,

        ["xfce4-panel"] = true,
        ["gimp-2.10"] = true,
        ["VirtualBox Machine"] = true,
        ["blueman-manager"] = true,
        ["color-picker"] = true,
        ["google-chrome"] = false,
        ["Google-chrome"] = true,



        gl = true,
        crx_hnpfjngllnobngcgfapefoaidbinmjnm = true,--whatsapp
        crx_cadlkienfkclaiaibeoongdcgmdikeeg = true,--chatgpt
        crx_majiogicmcnmdhhlgmkahaleckhjbmlk = true,--telegram
        PenTablet = true,
        nitrogen = true,
        xpad = true,
        gpick = true,
        pulsemixer = true,
        easyeffects = true,
        pavucontrol = true,
        rhythmbox = true,
        vlc = true,
        discord = false,
        iriunwebcam = true,
        localsend_app = true,
        amberol = true,
        Inkspace = true,
        flameshot = true,
        Alacritty = true,
   }

    if float_instances[c.instance] then
        c.floating = true
    else
        c.floating = false -- ← ISSO GARANTE QUE O RESTO NÃO SEJA FLUTUANTE
    end

    -- Centralização opcional
    -- (sugiro manter essa parte como está, pois não interfere no modo flutuante)
    local exclude_classes = {
        "kitty", "gimp", "blueman-manager", "tilix",
        "color-picker", "iriumwebcam", "amberol", "org.inkscape.Inkscape","Plank","Xfce4-panel","xfce4-panel",
        "Inkscape"
    }

    --local function is_excluded(client)
    --    for _, exclude_class in ipairs(exclude_classes) do
    --        if client.class == exclude_class or client.instance == exclude_class then
    --            return true
    --        end
    --    end
    --    return false
    --end

    --if not is_excluded(c) then
    --    local screen = awful.screen.focused()
    --    local workarea = screen.workarea
    --    local width = c.width
    --    local height = c.height

    --    c:geometry({
    --        x = workarea.x + (workarea.width - width) / 2,
    --        y = workarea.y + (workarea.height - height) / 2,
    --        width = width,
    --        height = height
    --    })
    --end
end)




local temperatura = require("widgets.temperatura") -- ajuste o caminho se necessário




-- Aumentar a temperatura (mais fria)
local function increase_temp()
    current_temp = math.min(current_temp + step_temp, 6500) -- Limite superior (máximo 6500K)
    awful.spawn.with_shell("redshift -O " .. current_temp)
end

-- Diminuir a temperatura (mais quente)
local function decrease_temp()
    current_temp = math.max(current_temp - step_temp, 4500)-- Limite inferior (mínimo 3000K)
    awful.spawn.with_shell("redshift -O " .. current_temp)
end

-- Restaurar temperatura padrão
local function reset_temp()
    current_temp = 6500  -- Volta ao valor inicial
    awful.spawn.with_shell("redshift -x")
end


local naughty = require("naughty")

local function notify_temp()
    naughty.notify({ text = "Temperatura atual: " .. current_temp .. "K" })
end

---- Exemplo ao ajustar a temperatura:
--local function increase_temp()
--    current_temp = math.min(current_temp + step_temp, 6500)
--    awful.spawn.with_shell("redshift -O " .. current_temp)
--    notify_temp()
--end





----------------------------------------------------------------------
---------------------------- ERROR -----------------------------------
----------------------------------------------------------------------

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

----------------------------------------------------------------------
---------------------------- UNCLUTTER -------------------------------
----------------------------------------------------------------------

-- {{{ Autostart windowless processes
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "", "unclutter -root" }) -- comma-separated entries

----------------------------------------------------------------------
---------------------------- OPTIONS ---------------------------------
----------------------------------------------------------------------

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. "nvim"
browser = "google-chrome"
fm = "thunar"

-- Default modkey.
--modkey = "Mod1" -- Alt
modkey = "Mod1" -- Alt
modkey1 = "Mod4" -- Win

-- Separator Blanc
sep = wibox.widget.textbox("   ")
sep1 = wibox.widget.textbox("") -- 󰇙 ") --("") --("  ") --("⏽") --("") 󰇙
space = wibox.widget.textbox(" ") -- 󰇙 ") --("") --("  ") --("⏽") --("") 󰇙
sep2 = wibox.widget.textbox(" 󱗿 ")
sep3 = wibox.widget.textbox(" ")
percent_widget = wibox.widget.textbox("%")
lay_widget = wibox.widget.textbox("Lay: ")
fs_widget = wibox.widget.textbox("FS:")
-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,

    lain.layout.termfair,
    --awful.layout.suit.tile.top,

    --lain.layout.termfair.center,
    --lain.layout.centerwork,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork.horizontal,
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2



----------------------------------------------------------------------
---------------------------- WIBAR - WIDGETS -------------------------
----------------------------------------------------------------------
-- Widgets https://github.com/streetturtle/awesome-wm-widgets
local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")


--WidgetLain

local cpu_1 = lain.widget.cpu {
    settings = function()
        --widget:set_markup("  " .. cpu_now.usage .. "%")
        --widget:set_markup("  " .. cpu_now.usage .. "%")
        widget:set_markup("CPU: " .. cpu_now.usage .. "%")
    end
}

local mem_1 = lain.widget.mem({
    settings = function()
        --widget:set_markup("  " .. mem_now.used .." MB")
        --widget:set_markup("  " .. mem_now.used .." MB")
        --widget:set_markup("MEM: " .. mem_now.used .."MB32GB")
        --widget:set_markup("MEM: " .. mem_now.used .."MB16GB")
        --widget:set_markup(" " .. mem_now.used .."32GB")
    end
})


local fsroothome = lain.widget.fs({
    settings  = function()
        --widget:set_text("󰆼 Disk% ")
        --widget:set_text("  /" .. fs_now ["/"].percentage .. "%" .. " ~/" ..  fs_now["/home"].percentage .. "%")
        --widget:set_text("󰆼 /" .. fs_now ["/"].percentage .. "%" .. " ~/" ..  fs_now["/home"].percentage .. "%")
        --widget:set_text("DISK:/" .. fs_now ["/"].percentage .. "%" .. " ~/" ..  fs_now["/home"].percentage .. "%")
        widget:set_text("DISK: " ..  fs_now["/home"].percentage .. "%")

    end
})

mysysload = lain.widget.sysload()




--WidgetVicious
wifi_widget = wibox.widget.textbox()
vicious.register(wifi_widget, vicious.widgets.wifi,
    function (widget, args)
        if args["{link}"] == 0 then
            return " "
            --return "No Wi-Fi  "
            --return " No Wi-Fi"
        else
            return " "
            --return "  " .. args["{ssid}"]
            --return args["{ssid}"] .. "  "
        end
        end, 10, "wlp0s20f3" -- Altere "wlp2s0" para o nome da sua interface Wi-Fi
)

local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "MEM: $1% /32GB", 2)




local mem_widget1 = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "MEM: --% --GB de --GB",
}

-- Widget de memória personalizada
vicious.register(mem_widget1, vicious.widgets.mem,
    function (widget, args)
        -- args[1] = uso em %
        -- args[2] = usado em MB
        -- args[3] = total em MB
        local used_gb  = string.format("%.1f", args[2] / 1024)
        local total_gb = string.format("%.0f", args[3] / 1024)
        --return "MEM: " .. args[1] .. "% " .. used_gb .. " GB/32GB" .. total_gb .. "GB"
        return "MEM: " .. args[1] .. "% " .. used_gb .. "GB/32GB"
    end,
5)

-- Cria o widget
local cpuwidget = wibox.widget.textbox()
-- Registra o widget com o vicious
vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: $1%", 2)

-- Widget moderno
local cputemp_widget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "CPU Temp: --°C",
}

-- Registra o widget
--vicious.register(cputemp_widget, vicious.widgets.thermal,
--    function (widget, args)
--        return  " /" .. args[1] .. "°C"
--    end, 5, "thermal_zone0"
--)

widget:set_markup("MEM: " .. mem_now.used .."MB32GB")
-- Cria o widget de texto para a bateria
local battery_widget1 = wibox.widget {
    {
        id = "percent",
        widget = wibox.widget.textbox,
        --font = "ProggyClean CE Nerd Font   Regular 12",
        font = "VictorMono                   Bold 9",
    },
    layout = wibox.layout.fixed.horizontal,
}

-- Função para atualizar o widget com os dados da bateria
local function update_battery(widget, stdout)
    local battery_percent = string.match(stdout, "(%d?%d?%d)%%")
    widget.percent.text = "" .. battery_percent .. "%"
    --widget.percent.text = "Battery: " .. battery_percent .. "%"
end

-- Comando para pegar o status da bateria (usando `acpi`)
watch("acpi -i", 30, update_battery, battery_widget1)


--Clock Widget 
-- Create a textclock widget
--mytextclock = wibox.widget.textclock()
--mytextclock = wibox.widget.textclock(" %I:%M  %d/%m/%y ", 1)
--mytextclock = wibox.widget.textclock(" %d/%m/%y %I:%M ", 1)
--mytextclock = wibox.widget.textclock("%d/%m/%y ~ %H:%M:%S", 1)
mytextclock = wibox.widget.textclock("%a %e %b %H:%M ", 1)

local cw = calendar_widget({
    theme = 'dark', --default ,nord, dark, tokyonight
    placement = 'center', --'top_right', --bottom, bottom_right, center, top_right
    start_sunday = false,
    radius = 7,
    -- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3,
})

mytextclock:connect_signal("button::press",function(_, _, _, button)
    if button == 1 then cw.toggle() end
end)

--local cpu = awful.widget.watch('/home/filipe/.config/scripts/wibar/cpu-wibox')
local cpu_hz = awful.widget.watch('/home/filipe/.config/scripts/cpu.sh')
local disk = awful.widget.watch('/home/filipe/.config/scripts/wibar/disk-bar')
local updates = awful.widget.watch('/home/filipe/.config/scripts/wibar/debian-updates')
local ram = awful.widget.watch('/home/filipe/.config/scripts/wibar/ram-wibox.bkp')
local weather = awful.widget.watch('/home/filipe/.config/scripts/wibar/weather-wibox')
local update = awful.widget.watch('/home/filipe/.config/scripts/wibar/updates-wibox')
local updatew = wibox.widget.background()
    updatew:set_widget(update)
    updatew:set_bg("#1a1a1a")
    updatew:set_shape(gears.shape.rectangular_tag)

-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

    if has_fdo then
        mymainmenu = freedesktop.menu.build({
            before = { menu_awesome },
            after =  { menu_terminal }
        })
    else
        mymainmenu = awful.menu({
            items = {
                      menu_awesome,
                      { "Debian", debian.menu.Debian_menu.Debian },
                      menu_terminal,
                    }
        })
    end

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
    mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a wibox for each screen and add it
    local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                        if c == client.focus then
                            c.minimized = false
                        else
                            c:emit_signal(
                                "request::activate",
                                "tasklist",
                                {raise = true}
                            )
                        end
                     end),

                    awful.button({ }, 3, function()
                        awful.menu.client_list({ theme = { width = 250 } })
                    end),

                    awful.button({ }, 4, function ()
                        awful.client.focus.byidx(1)
                    end),

                    awful.button({ }, 5, function ()
                        awful.client.focus.byidx(-1)
                    end))

    -- Wallpaper
    local function set_wallpaper(s)

        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)

    --Configs Wibar
    awful.screen.connect_for_each_screen(function(s)


  --#### espaço para dock
    s.padding = {
        bottom = 48,
        --left = 55,
    }




        -- Wallpaper
        --set_wallpaper(s)

        --Each screen has its own tag table.󰖟
        --awful.tag({"1","2","3","4","5"}, s, awful.layout.layouts[1])
        --awful.tag({" 1 "," 2 "," 3 "," 4 "," 5 "}, s, awful.layout.layouts[1])
        --awful.tag({"   󰬺","   󰬻","   󰬼","   󰬽","   󰬾","   󰬿"}, s, awful.layout.layouts[1])
        --awful.tag({" 󰬺 "," 󰬻 "," 󰬼 "," 󰬽 "," 󰬾 "," 󰬿 "," 󰭀 "," 󰭁 "}, s, awful.layout.layouts[1])
        awful.tag({" www "," float "," term "," files "," apps " }, s, awful.layout.layouts[1])
        --awful.tag({" 1-Web "," 2-Term "," 3-Files "," 4-Others "}, s, awful.layout.layouts[1])
        --awful.tag({"   www ","   term ","   docs ","   media ", "   [*] "}, s, awful.layout.layouts[1])
        --awful.tag({" www "," * "," cli "," docs "," media "}, s, awful.layout.layouts[1])
        --awful.tag({"  ","  ","  ","  ","  ","  ",}, s, awful.layout.layouts[1])
        --awful.tag({"  ","  ","  ","  ","  ","  ",}, s, awful.layout.layouts[1])
        --awful.tag({" 󰈿 "," 󰈿 "," 󰈿 ",}, s, awful.layout.layouts[1])
        --awful.tag({" 󰓹 "," 󰓹 "," 󰓹 "," 󰓹 "}, s, awful.layout.layouts[1])
        --awful.tag({"  ","  ","  ","  ","  "}, s, awful.layout.layouts[1])
        --awful.tag({" I "," II "," III "," IV "," V "}, s, awful.layout.layouts[1])
        --awful.tag({"[1]","[2]","[3]","[4]","[5]"}, s, awful.layout.layouts[1])
        --awful.tag({"Web ","Code ","3 ","4 ","5 ","6 "}, s, awful.layout.layouts[1])
        --awful.tag({" 󰖟 -web ","  -code "," 󰽰-music ","  -files ",}, s, awful.layout.layouts[1])
        --awful.tag({"󰫶 󰖟 ","󱂉  ","󱂊 󰽰","󱂋  ",}, s, awful.layout.layouts[1])
        --awful.tag({"󰖟 ","󱨧 "," "," "," ",}, s, awful.layout.layouts[1])
        --awful.tag({" "," "," "," "," "}, s, awful.layout.layouts[1])
        --awful.tag({" ","   ","   ","   ","   "}, s, awful.layout.layouts[1])
        --awful.tag({"    ","    ","    ","    ",}, s, awful.layout.layouts[1])
        --awful.tag({"    ","    ","    ","  󰀻  ",}, s, awful.layout.layouts[1])

        -- Each screen has its own tag table.
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)

        s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)
                             ))


        -- Create a taglist widget
        --s.mytaglist = awful.widget.taglist {
        --    screen  = s,
        --    filter  = awful.widget.taglist.filter.all,
        --    buttons = taglist_buttons
        --}

        --#### TAGLISTWIDGETS
        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,
            style = {
                shape = gears.shape.rounded_rect,--opcional, para adicionar estilo
            },
            layout  = {
                layout  = wibox.layout.fixed.horizontal,
            },
            widget_template = {
                {

                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },

                    {
                        id     = 'icon_layout',
                        widget = wibox.widget.imagebox,
                        layout = wibox.layout.fixed.horizontal, -- Permitir múltiplos ícones
                        align  = 'center', -- Centralizar verticalmente
                    },

                    layout = wibox.layout.fixed.horizontal,
                    valign = 'center', -- Garante o alinhamento vertical dos ícones
                },
                id     = 'background_role',
                widget = wibox.container.background,
                -- Atualizar os ícones ao selecionar a tag
                create_callback = function(self, t, index, objects)
                    local function update_icons()
                        local clients = t:clients()
                        local icon_layout = self:get_children_by_id('icon_layout')[1]

                        -- Limpa todos os ícones anteriores
                        --icon_layout:reset()


                        ---- Adiciona os ícones de todos os clientes
                        for _, c in ipairs(clients) do
                            if c.icon then
                                local icon_widget = wibox.widget {
                                    widget = wibox.widget.imagebox,
                                    image = c.icon,
                                    resize = true,
                                    forced_height = 16,
                                    forced_width = 16,
                                }
                                -- Centralizar verticalmente e adicionar margem ao redor de cada ícone
                                local icon_container = wibox.container.margin(
                                    wibox.container.place(icon_widget, "center"),
                                    0, 0, 0, 0 -- Espaçamento horizontal de 2px entre os ícones
                                )
                                icon_layout:add(icon_container)
                            end
                        end
                    end

                    -- Executa a função de atualização de ícones
                    update_icons()
                end,
                update_callback = function(self, t, index, objects)
                    local function update_icons()
                        local clients = t:clients()
                        local icon_layout = self:get_children_by_id('icon_layout')[1]

                        -- Limpa todos os ícones anteriores
                        icon_layout:reset()

                        -- Adiciona os ícones de todos os clientes
                        for _, c in ipairs(clients) do
                            if c.icon then
                                local icon_widget = wibox.widget {
                                    widget = wibox.widget.imagebox,
                                    image = c.icon,
                                    resize = true,
                                    forced_height = 16,
                                    forced_width = 16,
                                }
                                -- Centralizar verticalmente e adicionar margem ao redor de cada ícone
                                local icon_container = wibox.container.margin(
                                    wibox.container.place(icon_widget, "center"),
                                    0, 4, 1, 0 -- Espaçamento horizontal de 2px entre os ícones
                                )
                                icon_layout:add(icon_container)

                            end
                        end
                    end

                    -- executa a função de atualização de ícones
                    update_icons()
                end,
            },
        }

        -- TASLIST STANDARD
        ---- Create a tasklist widget
        --s.mytasklist = awful.widget.tasklist {
        --    screen  = s,
        --    filter  = awful.widget.tasklist.filter.focused,
        --    --filter  = awful.widget.tasklist.filter.currenttags,
        --    buttons = tasklist_buttons
        --}

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.focused,
            --filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            style = {
                shape = gears.shape.rounded_rect,
            },
            layout   = {
                spacing = 10,
                layout  = wibox.layout.fixed.horizontal,
            },

            widget_template = {
                {
                    {
                        {
                            {
                                id     = "icon_role", -- Widget que exibe o ícone
                                widget = wibox.widget.imagebox,
                            },
                            {
                                id     = "text_role", -- Widget que exibe o texto
                                widget = wibox.widget.textbox,
                            },
                            layout = wibox.layout.fixed.horizontal, -- Ícone e texto lado a lado
                            spacing = 5, -- Espaçamento entre ícone e texto
                        },
                        margins = 1,
                        widget  = wibox.container.margin,
                    },
                    --id     = "background_role",
                    widget = wibox.container.background,
                },
                --widget = wibox.container.margin,
                widget  = wibox.container.constraint,
                width   = 400, --tamanho máximo do nome


            },
        }

        --standard
        --local systray = wibox.widget.systray()

        local systray = wibox.widget {
            {
                wibox.widget.systray(),
                margins = 0,
                --margins = 3,
                widget = wibox.container.margin
            },
            bg = "#00000000",
            widget = wibox.container.background
        }

        --settings wibar
        --s.mywibox = awful.wibar({ position = "top", opacity = 1, screen = s, visible = true, height = 22, width = s.geometry.width, })
        s.mywibox = awful.wibar({ position = "top", opacity = 1, screen = s, height = 20, width = s.geometry.width, })
        --s.mywibox = awful.wibar({ position = "bottom", opacity = 0.9, screen = s, height = 20, width = s.geometry.width, })


        --systray.base_size = s.mywibox.height * 0.6
        local systray = wibox.container.margin(systray, 0, 0, 0, 0 )
        --local systray = wibox.container.margin(systray, 0, 0, 3, 2 )

        if s == screen.primary then
            -- Add widgets to the wibox
            s.mywibox:setup {
                layout = wibox.layout.align.horizontal,
                expand = "none",

                {   -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    --s.mylayoutbox,sep,
                    s.mylayoutbox,sep,
                    --mylauncher,sep3,
                    --sep,sep1,sep,
                    s.mytaglist,sep,
                    s.mytasklist,
                    sep,
                    --name1,
                    --sep,
                    --ram_widget(),
                    --mem1,
                    --sep,
                    spotify_widget({
                            --font = "FantasqueSansMNerdFont     Regular 12"
                            --font = "Victor Mono  Bold 10"
                            font = 'ProggyClean CE Nerd Font 12',
                            play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
                            pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg'
                    }),

                },

                {   -- Middle widget
                    layout = wibox.layout.flex.horizontal,
                    --s.mytasklist,
                    --s.mytaglist,

                    mytextclock,
                },

                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,

                    --lay_widget,
                    --s.mylayoutbox,
                    sep,
                    cpu_1,
                    temperatura,
                    --cputemp_widget,
                    --sep,
                    --cpu_widget(),
                    sep,
                    --memwidget,
                    mem_widget1,
                    --mem_1,
                    sep,
                    fsroothome,
                    sep,
                    --sep,
                    ----ram_widget(),
                    --mem1,
                    --sep,
                    --fsroothome,
                    --fs_widget(),
                    --batteryarc_widget({
                    --    show_current_level = true,
                    --    arc_thickness = 1,
                    --}),
                    --sep,
                    --brightness_widget(),
                    --sep1,
                    --todo_widget(),
                    --net_speed_widget(),
                    --weather,
                    --date,
                    --sep,
        --
                    ---VICIOUS WIDGETS
                    --widget_typeifi_widget,
                    --memwidget,
                    --cpuwidget,
                    systray,
                    sep,
                    volume_widget{widget_type = 'icon_and_text'},percent_widget,
                    --sep,
                    --battery_widget(),
                    --battery_widget1,
                    --sep1,
                    --mykeyboardlayout,
                    space,
                    logout_menu_widget(),
                    --sep,
                    --mytextclock,
                },
            }


        else

            -- Configuração do segundo monitor (apenas taglist e relógio)
            s.mywibox:setup {
                layout = wibox.layout.align.horizontal,
                expand = 'none',

                {   -- Left widgets (apenas taglist)
                    layout = wibox.layout.fixed.horizontal,

                    --mylauncher,sep3,

                    s.mylayoutbox,
                    sep,
                    s.mytaglist,
                    --s.mytasklist,
                    },

                {   -- Middle widget (vazio)
                    layout = wibox.layout.flex.horizontal,
                    mytextclock,
                },

                {   -- Right widgets (apenas relógio)
                    layout = wibox.layout.fixed.horizontal,

                    fsroothome,
                    sep,sep1,sep,
                    cpu_hzu_1,
                    --temperatura,
                    sep,
                    cpu_widget(),
                    sep,sep1,sep,
                    mem_1,
                    sep,sep1,sep,
                    volume_widget{widget_type = 'icon_and_text'},percent_widget,
                    sep,
                    battery_widget(),
                    battery_widget1,
                    --sep1,
                    --mykeyboardlayout,
                    --sep1,
                    --mytextclock,
                    --sep,
                    logout_menu_widget(),
                    --sep,
                    --mytextclock,
                },
            }
    end


    end)


----------------------------------------------------------------------
---------------------------- KEY_BINDINGS ----------------------------
----------------------------------------------------------------------
globalkeys = gears.table.join(

    -- Standard Program
    awful.key({ modkey1,           }, "1" , function () awful.spawn(browser) end,
            {description = "open a browser", group = "launcher"}),
    awful.key({ modkey1,           }, "2" , function () awful.spawn(fm) end,
            {description = "open a file manager", group = "launcher"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
            {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey1,  }, "l", function () awful.spawn('i3lock -c 000000') end,
            {description = "open a terminal", group = "launcher"}),
    --awful.key({ modkey1,          }, "l", function () awful.spawn('gdmflexiserver --lock') end,
    --        {description = "Lockscreen", group = "Custom"}),
    --awful.key({ modkey, "Control"  }, "l", function () awful.spawn('xscreensaver-command -l') end,
            --{description = "open a terminal", group = "launcher"}),
    awful.key({ modkey1,          }, "BackSpace", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
            {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,         },   "a",    function () awful.spawn("alacritty -e pulsemixer") end,
            {description = "Exec pulsemixer", group = "Custom"}),
    awful.key({ modkey,         },   "b",    function () awful.spawn("blueman-manager") end,
            {description = "Exec pulsemixer", group = "Custom"}),
    awful.key({ modkey,         },  "s",    function () awful.spawn("kitty -e ranger") end,
            {descrption = "Open ranger", group = "Custom"}),
    --awful.key({ modkey,         },  "a",    function () awful.spawn("kitty -e /home/filipe/.dotfiles/.config/ranger/rangerdownloads.sh") end,
    --        {descrption = "Open ranger", group = "Custom"}),
    awful.key({ modkey,         },  "o",    function () awful.spawn("xpad -s") end,
            {descrption = "show xpad", group = "personal launchers"}),
    awful.key({ modkey,         },  "k",    function () awful.spawn("xpad -h") end,
            {descrption = "Hide Xpad", group = "Custom"}),
    awful.key({ modkey, "Control"      },  "n",    function () awful.spawn("xpad -n") end,
            {descrption = "New Xpad", group = "Custom"}),
    --awful.key({ modkey,         },   "l",    function () awful.spawn("rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history ") end,
    --         {description = "Rofi-apps", group = "Custom"}),
    --awful.key({ modkey,         },   "l",    function () awful.spawn("tilix -e qalc") end,
    --         {description = "Rofi-apps", group = "Custom"}),
    awful.key({ modkey, "Control"  },   "d",    function () awful.spawn("alacritty -e pactl load-module module-combine-sink sink_name=COMBINED_SINK && exit") end,
             {description = "Combine Sink", group = "Custom"}),
    --awful.key({ modkey1, }, "p", function()  awful.spawn.with_shell(" kitty -e /home/filipe/.config/scripts/toggle_monitors.sh") end,
            --{description = "Alternar monitores", group = "custom"}),
    awful.key({ modkey1,            },   "c",    function () awful.spawn("alacritty -e /home/filipe/.config/scripts/qalc-term.sh") end,
             {description = "Rofi-apps", group = "Custom"}),

awful.key({ modkey }, "e", function ()
    awful.spawn.with_shell("$HOME/.local/bin/rofimoji --selector rofi --action copy")
end,
{description = "Selecionar emoji com Rofimoji", group = "launcher"}),

    awful.key({          },   "F1",    function () awful.spawn("rofi -show drun -display-drun ' Exec ' ") end,
             {description = "Rofi-apps", group = "Custom"}),
    awful.key({ "Control",         },   "space",    function () awful.spawn("rofi -show drun -display-drun ' Exec ' ") end,
             {description = "Rofi-apps", group = "Custom"}),
    awful.key({ modkey,        },   "Tab",      function () awful.spawn("rofi -show window ' Exec ' ") end,
            {description = "Rofi-switch-apps", group = "Custom"}),
    awful.key({ modkey,        },   "c",      function () awful.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command ' Exec ' ") end,
            {description = "Rofi-greenclip", group = "Custom"}),
    awful.key({ modkey         },   "t",      function () awful.spawn("kitty -e htop") end,
            {description = "Open htop", group = "Custom"}),
    awful.key({ modkey         },   "r",        function () awful.spawn("/home/filipe/.config/scripts/rofi/rofi-files") end,
            {description = "Search files", group = "Custom"}),
    awful.key({ modkey         },   "p",        function () awful.spawn("/home/filipe/.config/scripts/rofi/rofi-search") end,
            {description = "Rofi-search", group = "Custom"}),
    awful.key({ modkey         },   "x",        function () awful.spawn("/home/filipe/.config/scripts/rofi/power-menu.sh") end,
            {description = "Power-menu.sh", group = "Custom"}),
    awful.key({ modkey         },   "u",        function () awful.spawn("/home/filipe/.config/scripts/wibar/autoupdate.sh") end,
            {description = "Check Updates", group = "Custom"}),

    --REDSHIFT
    -- Aumentar a temperatura (mais fria)
    awful.key({ modkey1  }, "Up", function()
        increase_temp()
    end, {description = "Aumentar temperatura da cor", group = "Custom"}),

    -- Diminuir a temperatura (mais quente)
    awful.key({ modkey1 }, "Down", function()
        decrease_temp()
    end, {description = "Diminuir temperatura da cor", group = "Custom"}),

    -- Restaurar temperatura padrão
    awful.key({ modkey1 }, "r", function()
        reset_temp()
    end, {description = "Restaurar temperatura padrão", group = "Custom"}),


    --Volume
    awful.key({ "Control"                }, "Delete", function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")end,
            {description = "Mutar volume", group = "Custom" }),

    awful.key({ "Control"      },   "Up",      function () awful.spawn("/home/filipe/.config/scripts/notify/volume+") end,
            {description = "exec volup", group = "Custom"}),

    awful.key({ "Control"      },   "Down",    function () awful.spawn("/home/filipe/.config/scripts/notify/volume-") end,
            {descritipn = "exec voldown", group = "Custom"}),

    awful.key({                }, "XF86AudioRaiseVolume",     function () awful.spawn("/home/filipe/.config/scripts/notify/volume+") end,
            {description = "exec volup", group = "Custom"}),

    awful.key({                }, "XF86AudioLowerVolume",     function () awful.spawn("/home/filipe/.config/scripts/notify/volume-") end,
            {descritipn = "exec voldown", group = "Custom"}),

     -- Configuração de atalhos de teclado (KNOB DO VOLUME)
     --        awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
     --             {description = "Aumentar volume", group = "Volume"}),

     --        awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
     --             {description = "Diminuir volume", group = "Volume"}),

    awful.key({                }, "XF86AudioMute", function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")end,
            {description = "Mutar volume", group = "Custom" }),

    awful.key({ modkey,        }, "i",      hotkeys_popup.show_help,
            {description="show help", group="awesome"}),

    --  Control Clients
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
            {description = "go back", group = "tag"}),

    --awful.key({ modkey, "Control" }, "Tab", awful.tag.history.restore,
    --          {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "y", function () mymainmenu:show() end,
            {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),

    --awful.key({ modkey,           }, "Escape", function () awful.screen.focus_relative( 1) end,
    --        {description = "focus the next screen", group = "screen"}),

    -- MUDAR DE MONITOR
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "0", function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),


    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
    --awful.key({ modkey,           }, "Tab",function () awful.client.focus.history.previous()
            --if client.focus then
                --client.focus:raise()
            --end
    --end,
            --{description = "go back", group = "client"}),

     -- Control Clients
     --awful.key({ "Control",           }, "j",   awful.tag.viewprev,
     --          {description = "view previous", group = "tag"}),

     --awful.key({ "Control",           }, "k",  awful.tag.viewnext,
     --          {description = "view next", group = "tag"}),

    awful.key({ modkey, 	  }, "n",  awful.client.floating.toggle,
            {description = "toggle floating", group = "client"}),

    -- Layout Manipulation
    --awful.key({ modkey,           }, "Tab", function () awful.client.focus.byidx( 1) end,
    --        {description = "focus next by index", group = "client"}),


    awful.key({ modkey,           }, "l", function () awful.client.focus.byidx( 1) end,
            {description = "focus next by index", group = "client"}),
    awful.key({ modkey,          }, "h", function () awful.client.focus.byidx(-1) end,
            {description = "focus previous by index", group = "client"}),


    awful.key({ modkey,          }, "Right", function () awful.client.focus.byidx(1) end,
            {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,          }, "Left", function () awful.client.focus.byidx(-1) end,
            {description = "focus previous by index", group = "client"}),




    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),


    -- manipulação das janelas
    awful.key({ modkey, "Control"          }, "l",     function () awful.tag.incmwfact( -0.05) end,
            {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey, "Control"          }, "h",   function () awful.tag.incmwfact(0.05) end,
            {description = "decrease master width factor", group = "layout"}),


    awful.key({ modkey, "Control"          }, "Right",     function () awful.tag.incmwfact(0.05) end,
            {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey, "Control"          }, "Left",     function () awful.tag.incmwfact(-0.05) end,
            {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Control" }, "Down", function () awful.client.incwfact(-0.05) end,
            {description = "diminuir altura da janela", group = "layout"}),

    awful.key({ modkey, "Control" }, "Up", function () awful.client.incwfact(0.05) end,
            {description = "aumentar altura da janela", group = "layout"}),



    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),

    -- Screen brightness
   -- awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
   --           {description = "+10%", group = "hotkeys"}),
   -- awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
   --           {description = "-10%", group = "hotkeys"}),


   awful.key({"Control","Shift"  }, "Up", function () os.execute("brightnessctl set +10%") end,
             {description = "+10%", group = "hotkeys"}),
   awful.key({"Control","Shift"  }, "Down", function () os.execute("brightnessctl set 10%-") end,
             {description = "-10%", group = "hotkeys"}),

   awful.key({ }, "XF86MonBrightnessUp", function () os.execute("brightnessctl set +10%") end,
             {description = "+10%", group = "hotkeys"}),
   awful.key({ }, "XF86MonBrightnessDown", function () os.execute("brightnessctl set 10%-") end,
             {description = "-10%", group = "hotkeys"}),

   awful.key({ modkey, "Control" }, "k",
           function ()
               local c = awful.client.restore()
               -- Focus restored client
                   if c then
                       c:emit_signal(
                       "request::activate", "key.unminimize", {raise = true}
                   )end
           end,
           {description = "restore minimized", group = "client"}),

   -- Tirar print com Flameshot usando a tecla Print
   awful.key({modkey1}, "w", function () awful.spawn("flameshot gui") end,
             {description = "Take screenshot", group = "screenshot"}),
   -- Prompt
   awful.key({ modkey },            "F6",     function () awful.screen.focused().mypromptbox:run() end,
       {description = "run prompt", group = "launcher"}),
   -- awful.key({ modkey }, "l",
   --           function ()
   --               awful.prompt.run {
   --                 prompt       = "Run Lua code: ",
   --                 textbox      = awful.screen.focused().mypromptbox.widget,
   --                 exe_callback = awful.util.eval,
   --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
   --               }
   --           end,
   --           {description = "lua execute prompt", group = "awesome"}),

   -- Menubar
   awful.key({ modkey }, "--", function() menubar.show() end,
            {description = "show the menubar", group = "launcher"})

)

    clientkeys = gears.table.join(
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
        {description = "toggle fullscreen", group = "client"}),




    -- Alternar a visibilidade da barra no primeiro monitor
    awful.key({ modkey }, "w", function()
        local s = screen[1] -- Substitua por screen.primary se for usar no monitor principal
        if s.mywibox then
            s.mywibox.visible = not s.mywibox.visible
        end
    end, {description = "Alternar visibilidade da barra", group = "Custom"}),

    -- Alternar a visibilidade da barra no primeiro monitor
    --awful.key({ modkey }, "w", function()
    --    local s = screen[2] -- Substitua por screen.primary se for usar no monitor principal
    --    if s.mywibox then
    --        s.mywibox.visible = not s.mywibox.visible
    --    end
    --end, {description = "Alternar visibilidade da barra", group = "custom"}),


    -- Close Clients
         awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
         awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
                   {description = "toggle floating", group = "client"}),
         awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                   {description = "move to master", group = "client"}),
         awful.key({ modkey, "Control"   }, "Escape",      function (c) c:move_to_screen()               end,
                   {description = "move to screen", group = "client"}),
         awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                   {description = "toggle keep on top", group = "client"}),
         awful.key({ modkey,           }, "n",
             function (c)
                 -- The client currently has the input focus, so it cannot be
                 -- minimized, since minimized clients can't have the focus.
                 c.minimized = true
             end ,
             {description = "minimize", group = "client"}),

         awful.key({ modkey,           }, "m",
             function (c)
                 c.maximized = not c.maximized
                 c:raise()
             end ,
             {description = "(un)maximize", group = "client"}),

         awful.key({ modkey, "Control" }, "m",
             function (c)
                 c.maximized_vertical = not c.maximized_vertical
                 c:raise()
             end ,
             {description = "(un)maximize vertically", group = "client"}),

         awful.key({ modkey, "Shift"   }, "m",
             function (c)
                 c.maximized_horizontal = not c.maximized_horizontal
                 c:raise()
             end ,
             {description = "(un)maximize horizontally", group = "client"})
)

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = gears.table.join(globalkeys,
            -- View tag only.
            awful.key({ modkey           }, "#" .. i + 9,
                      function ()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                               tag:view_only()
                            end
                      end,
                      {description = "view tag #"..i, group = "tag"}),

            -- Toggle tag display.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                      function ()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end,
                      {description = "toggle tag #" .. i, group = "tag"}),

            -- Move client to tag.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:move_to_tag(tag)
                              end
                         end
                      end,
                      {description = "move focused client to tag #"..i, group = "tag"}),

            -- Toggle tag on focused client.
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:toggle_tag(tag)
                              end
                          end
                      end,
                      {description = "toggle focused client on tag #" .. i, group = "tag"})
        )
    end


    clientbuttons = gears.table.join(
        awful.button({ }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),

        awful.button({ modkey }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),

        awful.button({ modkey }, 3, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    -- Set keys
    root.keys(globalkeys)

    local function client_status(client)

        local layout = awful.layout.get(mouse.screen)

        if (layout == awful.layout.suit.floating) or (client and client.floating) then
            return "floating"
        end

        if layout == awful.layout.suit.max then
            return "max"
        end

        return "other"

    end


----------------------------------------------------------------------
---------------------------- RULES -----------------------------------
----------------------------------------------------------------------

-- Função para bloquear a tela
--function lock_screen()
--    awful.spawn.with_shell("i3lock")
--end

--function lock_screen()
--    awful.spawn.with_shell("gdmflexiserver --lock")
--end


-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {





    -- All clients will match this rule.
    { rule = {},
        properties = { placement = awful.placement.centered,
                       border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       --floating = true,
                       keys = clientkeys,
                       buttons = clientbuttons,
                       screen = awful.screen.preferred,
                       placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },





  -- Plank dock
{ 
    rule = { class = "Xfce4-panel" },
    properties = {
        ontop = true,
        skip_taskbar = true,
        focusable = false,
        sticky = true
    }
},

-- Regras padrão (não remova)
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },


--FIXTAG

    --{
    --    rule = { class = "Google-chrome"},
    --    properties = {
    --        floating = false,
    --        --tag = " ",
    --        tag = " www ",
    --        --tag = " ",
    --        screen = 1,
    --        switch_to_tags = true
    --    }
    --},

    {
        rule = { class = "kitty"},
        properties = {
            --tag = "  ",
            tag = " term ",
            screen = 1,
            switch_to_tags = true
        }
    },

    {
        rule = { class = "Thunar"},
        properties = {
            tag = " files ",
            --tag = "  ",
            screen = 1,
            switch_to_tags = true
        }
    },

    {
        rule_any = {
            class = { "discord", "Nitrogen","chromium","localsend_app","Localsend_app", }
        },
        properties = {
            --tag = "  ",
            tag = " apps ",
            screen = 1,
            switch_to_tags = true
        }
    },

    {
        rule_any = {
            class = { "crx_hnpfjngllnobngcgfapefoaidbinmjnm", "crx_cadlkienfkclaiaibeoongdcgmdikeeg", "crx_majiogicmcnmdhhlgmkahaleckhjbmlk", }
        },
        properties = {
            tag = " float ",
            --tag = "  ",
            screen = 1,
            switch_to_tags = true
        }
    },


 -- --APLICATIVOS CENTRALIZADOS
 --   { rule_any = {
 --       class = {"kitty", "xpad","discord", "Alacritty", ... } --Incluir lista de aplicativos para centralizar
 --     },
 --     properties = {
 --       floating = true,
 --       placement = awful.placement.centered,
 --     }
 --   },


    
    -- barra de títulos #titlebar
    -- Add titlebars to normal clients and dialogs
    --{ rule_any = {type = { "normal", "dialog" }
    --  }, properties = { titlebars_enabled = true }
    --},


-- Regra para APPS DE TAMANHO FIXO
    {
        rule = { instance = "qalc-term" },
            properties = { width = 200, height = 400 }
            --properties = { floating = true }
    },

    {
        rule = { class = "kitty" },
            properties = { width = 1400, height = 1000 }
    },

    {
        rule = { class = "alacritty" },
            properties = { width = 1400, height = 1000 }
    },



    {
        rule = { class = "firefox-esr" },
            properties = { width = 1400, height = 1000 }
    },

    --{
    --    rule = { class = "Google-chrome" },
    --        properties = { width = 1345, height = 735 }
    --},

    { rule = { class = "Authenticator" },
        properties = { floating = true, ontop = true }
    },

    { rule = { class = "Inkscape" },
        properties = { maximized = false }
    },

    {
        rule = { class = "Alacritty" },
            properties = { width = 200, height = 200 }
    },
}

----------------------------------------------------------------------
---------------------------- SIGNALS ---------------------------------
----------------------------------------------------------------------

-- Floating windows are `always on top` by default.
--client.connect_signal("property::floating", function(c) c.ontop = c.floating end)

client.connect_signal("property::floating", function(c)
    if not c.fullscreen then
        if c.floating then
            c.ontop = true
        else
            c.ontop = false
        end
    end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
-- Set the windows at the slave,

    -- regra pra fazer os apps iniciarem minimizados
    --if c.class == "Localsend_app" then -- Substitua pelo valor correto do WM_CLASS
    --    c.minimized = true
    --end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients filipeom being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

end)


-- TITLEBARS/barradetitulos
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 20}) : setup {
        { -- Left
            --awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            --{ -- Title
            --    align  = "center",
            --    widget = awful.titlebar.widget.titlewidget(c)
            --},
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.minimizebutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)



-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal end)

----------------------------------------------------------------------
---------------------------- GAPS ------------------------------------
----------------------------------------------------------------------

beautiful.useless_gap = 6,

--beautiful.gap_single_client   = false

-- No borders when rearranging only 1 non-floating or maximized client
--  screen.connect_signal("arrange", function (s)
--    local only_one = #s.tiled_clients == 1
--    for _, c in pairs(s.clients) do
--        if only_one and not c.floating or c.maximized then
--            c.border_width = 0
--        else
--            c.border_width = 1 -- your border width
--        end
--    end
--end)


----------------------------------------------------------------------
---------------------------- XRANDR ----------------------------------
----------------------------------------------------------------------
--NOTE EM BAIXO
--awful.spawn.with_shell('xrandr --output DP-1 --primary --mode 2560x1440 --rate 75 --pos 0x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 536x1440 --rotate normal --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off')

--left
--awful.spawn.with_shell('xrandr --output DP-1 --primary --mode 2560x1440 --rate 75 --pos 1366x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 0x160 --rotate normal --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off')

--offnote
--awful.spawn.with_shell('xrandr --output DP-1 --primary --mode 2560x1440 --rate 75  --pos 0x0 --rotate normal --output eDP-1 --off')

--awful.spawn.with_shell('xrandr --output DP-1 --primary') --via displayport

--solo
--awful.spawn.with_shell('xrandr --output DP-0 --primary --mode 2560x1440 --rate 100  --output eDP-1 --off')--filesystem

awful.spawn.with_shell('xrandr')
awful.spawn.with_shell('xrandr --rate 100')
--awful.spawn.with_shell('xrandr --output DisplayPort-0 --mode 2560x1440 --rate 100 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --off')



awful.spawn.with_shell('xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 100 --pos 0x0 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --off')

--espelhar/samsung-quarto
--awful.spawn.with_shell('xrandr --output HDMI-A-0 --mode 2560x1440 --same-as DisplayPort-0')


----------------------------------------------------------------------
---------------------------- AUTOSTART -------------------------------
----------------------------------------------------------------------
awful.spawn.with_shell("sleep 2 && nm-applet")
--awful.spawn.with_shell('autorandr') --bluetooth
awful.spawn.with_shell('blueman-applet') --bluetooth
awful.spawn.with_shell('blueman-tray') --bluetooth
awful.spawn.with_shell('setxkbmap us alt-intl')
awful.spawn.with_shell('xset r rate 300 50')
awful.spawn.with_shell('xset s 1800 120') -- 10min para desligar a tela
awful.spawn.with_shell('xset -dpms')
--awful.spawn.with_shell('xautolock -time 1 -locker -notify 30 "gdm.service"') -- Iniciar xautolock com um tempo de 10 minutos (600 segundos)
--awful.spawn.with_shell("xautolock -time 40 -locker 'i3lock -c 000000'") -- Iniciar xautolock com um tempo de 10 minutos (600 segundos)
--awful.spawn.with_shell('blueman-manager') --bluetooth
--awful.spawn.with_shell('setxkbmap us intl') -- teclado Ansi
--awful.spawn.with_shell('/home/filipe/.config/scripts/notify/autoupdate.sh')
--awful.spawn.with_shell('xset s off') -- para não desligar a tela
--awful.spawn.with_shell('xscreensaver') -- papel de parede na tela de bloqueio

-- apps
awful.spawn.with_shell('/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1')
awful.spawn.with_shell('nitrogen --restore') -- controlador de wallpaper
awful.spawn.with_shell('picom --experimental-backends') --background transluced
--awful.spawn.with_shell('parcellite') --gerenciador de área de transferencia
awful.spawn.with_shell("greenclip daemon")
awful.spawn.with_shell('fusuma -d')
awful.spawn.with_shell('xdotool')
--awful.spawn.with_shell('xsel')
awful.spawn.with_shell('xclip')
awful.spawn.with_shell("xsel --output --primary | xsel --input --clipboard")
awful.spawn.with_shell("autocutsel -fork")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("xfce4-panel")
--awful.spawn.with_shell("easyeffects --hide-window")
--awful.spawn.with_shell('syncthing')
--awful.spawn.with_shell('pactl load-module module-combine-sink sink_name=COMBINED_SINK')
awful.spawn.with_shell('flameshot') --bater print
--awful.spawn.with_shell('cmst -m') --gerenciador de área de transferencia
--awful.spawn.with_shell('xpad -h') -- "-h" -> hide "-s" -> show
--awful.spawn.with_shell('localsend_app') --localsend
--awful.spawn.with_shell('knotes')


--require("dock.dock")
