-- Andre Anjos <andre.dos.anjos@gmail.com>
-- 2022-03-03 09:11


-- Auto-reloads the current configuration and displays a notice
rc = hs.loadSpoon("ReloadConfiguration")
rc:start()


-- Default hotkeys for actions
defaultHotKeys = {"cmd", "alt", "ctrl"}


-- Opens a new modal where we can launch applications
modal = hs.hotkey.modal.new("cmd", "escape")


-- Monitors wifi for changes (drop-offs)
currentWifi = hs.wifi.currentNetwork()
if currentWifi == nil then
    hs.alert.show("No Wifi")
else
    hs.alert.show("Wifi: " .. currentWifi)
end
function notifyOnWifiChange()
    newWifi = hs.wifi.currentNetwork()
    if newWifi == nil then
        if currentWifi == nil then
            hs.alert.show("No Wifi")
        else
            hs.alert.show("Wifi " .. currentWifi .. " disconnected")
        end
    elseif currentWifi ~= newWifi then
        hs.alert.show("Wifi: " .. newWifi)
    end
    currentWifi = newWifi
end
wn = hs.wifi.watcher.new(notifyOnWifiChange)
wn:start()


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
  --modal.triggered = true
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
  -- modal:bind({}, app[1], function() launch(app[2]); modal:exit(); end)
  hs.hotkey.bind(defaultHotKeys, app[1], function() launch(app[2]); end)
end

-- Locks the screen by pressing Delete
hs.hotkey.bind(defaultHotKeys, "escape", "Lock screen", hs.caffeinate.lockScreen)


-- Increases the size of the window vertically only
-- Useful if switching monitors and want to increase window size to occupy the
-- full height of the newly available media
-- modal:bind({}, "Down", function()
hs.hotkey.bind(defaultHotKeys, "down", "Window maximised vertically", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)

-- Toggles fullscreen mode of current window
function toggleFullscreen()
   local win = hs.window.focusedWindow()
   if win ~= nil then
      win:setFullScreen(not win:isFullScreen())
   end
end
hs.hotkey.bind(defaultHotKeys, ".", "Toggle fullscreen", toggleFullscreen)


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
function nextKeyboardLayout()
    allKeyboardLayouts = hs.keycodes.layouts()
    currentKeyboardLayout = indexOf(allKeyboardLayouts, hs.keycodes.currentLayout())
    -- hs.alert.show("Keyboard: " .. allKeyboardLayouts[currentKeyboardLayout] .. " [" .. currentKeyboardLayout .. "]")
    currentKeyboardLayout = currentKeyboardLayout + 1
    if currentKeyboardLayout > #allKeyboardLayouts then
        currentKeyboardLayout = 1
    end
    hs.keycodes.setLayout(allKeyboardLayouts[currentKeyboardLayout])
    hs.alert.show("Keyboard: " .. allKeyboardLayouts[currentKeyboardLayout])
end
-- modal:bind({}, 'k', nextKeyboardLayout)
hs.hotkey.bind(defaultHotKeys, "k", nextKeyboardLayout)

hs.alert.show("Configuration reloaded")
