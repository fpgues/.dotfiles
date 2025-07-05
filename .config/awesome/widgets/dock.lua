local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- Função para criar um ícone clicável
local function create_icon(image_path, command)
    local icon = wibox.widget {
        image  = image_path,
        resize = true,
        widget = wibox.widget.imagebox
    }

    -- Adiciona evento de clique
    icon:buttons(gears.table.join(
        awful.button({}, 1, function() awful.spawn(command) end)
    ))

    return icon
end

-- Ícones do dock
local dock_icons = {
    create_icon("/usr/share/icons/hicolor/48x48/apps/firefox.png", "firefox"),
    create_icon("/usr/share/icons/hicolor/48x48/apps/kitty.png", "kitty"),
    create_icon("/usr/share/icons/hicolor/48x48/apps/thunar.png", "thunar"),
    -- Adicione mais se quiser
}

-- Wibox do dock
local dock = awful.wibar({
    position = "bottom",
    screen = screen.primary,
    width = 400,
    height = 60,
    ontop = true,
    bg = "#00000000", -- transparente
    shape = gears.shape.rounded_rect,
    x = (screen.primary.geometry.width - 400) / 2,
    y = screen.primary.geometry.height - 70,
})

-- Layout interno do dock
dock:setup {
    layout = wibox.layout.fixed.horizontal,
    spacing = 15,
    unpack(dock_icons)
}
