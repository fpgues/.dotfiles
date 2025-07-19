--local awful = require("awful")
--local wibox = require("wibox")
--local gears = require("gears")
--
--local cpu_icon = "/"
--local gpu_icon = "GPU:"
--
--local temp_widget = wibox.widget {
--    widget = wibox.widget.textbox,
--    font = "FantasqueSansMNerdFont Regular 12"
--}
--
--local function update_temp()
--    awful.spawn.easy_async_with_shell(
--        [[
--        cpu=$(sensors | grep -m 1 'Tctl:' | awk '{print $2}')
--        gpu=$(sensors | grep -m 1 'edge:' | awk '{print $2}')
--        echo "$cpu $gpu"
--        ]],
--        function(stdout)
--            local cpu_temp, gpu_temp = stdout:match("([%+%-]%d+%.?%d*°C?)%s+([%+%-]%d+%.?%d*°C?)")
--            if cpu_temp and gpu_temp then
--                temp_widget.text = string.format("%s%s %s%s", cpu_icon, cpu_temp, gpu_icon, gpu_temp)
--            else
--                temp_widget.text = "Temp: n/a"
--            end
--        end
--    )
--end
--
--gears.timer {
--    timeout = 2,
--    autostart = true,
--    callback = update_temp
--}
--
--update_temp()
--
--return temp_widget




local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local cpu_icon = "/"
local gpu_icon = "GPU:"

local temp_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = "FantasqueSansMNerdFont Regular 12"
}

local function update_temp()
    awful.spawn.easy_async_with_shell(
        [[
        cpu_temp=$(sensors | grep -m 1 'CPU:' | awk '{print $2}')
        gpu_temp=$(sensors | grep -m 1 'edge:' | awk '{print $2}')

        if [ -f /sys/class/drm/card0/device/gpu_busy_percent ]; then
            gpu_usage=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
        else
            gpu_usage="N/A"
        fi

        echo "$cpu_temp $gpu_usage $gpu_temp"
        ]],
        function(stdout)
            local cpu_temp, gpu_use, gpu_temp = stdout:match("([%+%-]%d+%.?%d*°C?)%s+(%d+)%s+([%+%-]%d+%.?%d*°C?)")
            if cpu_temp and gpu_use and gpu_temp then
                temp_widget.text = string.format("%s%s %s %s%%/%s", cpu_icon, cpu_temp, gpu_icon, gpu_use, gpu_temp)
            else
                temp_widget.text = "Temp: n/a"
            end
        end
    )
end

gears.timer {
    timeout = 2,
    autostart = true,
    callback = update_temp
}

update_temp()

return temp_widget
