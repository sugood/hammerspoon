local hotkey = require "hs.hotkey"
local caffeinate = require "hs.caffeinate"
local audiodevice = require "hs.audiodevice"

hotkey.bind(hyper, "L", function()
  caffeinate.lockScreen()
  -- caffeinate.startScreensaver()
end)

-- mute on sleep
function muteOnWake(eventType)
  if (eventType == caffeinate.watcher.systemDidWake) then
    local output = audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end
caffeinateWatcher = caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()