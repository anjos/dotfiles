-- Andre Anjos <andre.dos.anjos@gmail.com>
-- 2022-03-03 09:11


-- Auto-reloads the current configuration and displays a notice
rc = hs.loadSpoon("ReloadConfiguration")
rc:start()


-- Monitors wifi for changes (drop-offs)
currentWifi = hs.wifi.currentNetwork()
hs.alert.show("Wifi: " .. currentWifi)
function notifyOnWifiChange()
    newWifi = hs.wifi.currentNetwork()
    if newWifi == nil then
        hs.alert.show("Wifi " .. currentWifi .. " disconnected")
    elseif currentWifi ~= newWifi then
        hs.alert.show("Wifi: " .. newWifi)
    end
    currentWifi = newWifi
end
wn = hs.wifi.watcher.new(notifyOnWifiChange)
wn:start()


-- Opens a new modal where we can launch applications
modal = hs.hotkey.modal.new("cmd", "escape")

-- Waits only 1 second on that "modal" state, then give up
function modal:entered()
    -- hs.alert.show("Modal start")
    hs.timer.doAfter(1, function() self:exit() end)
end

function modal:exited()
    -- hs.alert.show("Modal ended")
end


-- Launch or focus apps
launch = function(appname)
  hs.application.launchOrFocus(appname)
  hs.alert.show("Focus: " .. appname)
  modal.triggered = true
end

-- Single keybinding for app launch
singleapps = {
  {"m", "Spark"},
  {"s", "Safari"},
  {"t", "iTerm"},
  {"x", "Mattermost"},
  {"c", "Calendar"}
}

for i, app in ipairs(singleapps) do
  modal:bind({}, app[1], function() launch(app[2]); modal:exit(); end)
end



-- Increases the size of the window vertically only
-- Useful if switching monitors and want to increase window size to occupy the
-- full height of the newly available media
modal:bind({}, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    f.h = max.h
    win:setFrame(f)
    hs.alert.show("Window: Maximised vertically")
end)


function dumpTable(o)
   if type(o) == "table" then
      local s = "{ "
      for k,v in pairs(o) do
         if type(k) ~= "number" then k = "" .. k .. "" end
         s = s .. "[" .. k .. "] = " .. dumpTable(v) .. ","
      end
      return s .. "} "
   else
      return tostring(o)
   end
end

-- Return the first index with the given value (or nil if not found).
function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

-- Loops over the next keyboard layout available
all_layouts = hs.keycodes.layouts()
current_keyboard = indexOf(all_layouts, hs.keycodes.currentLayout())
function nextKeyboardLayout()
    -- hs.alert.show("Keyboard: " .. all_layouts[current_keyboard] .. " [" .. current_keyboard .. "]")
    current_keyboard = current_keyboard + 1
    if current_keyboard > #all_layouts then
        current_keyboard = 1
    end
    hs.keycodes.setLayout(all_layouts[current_keyboard])
end
modal:bind({}, 'k', nextKeyboardLayout)
