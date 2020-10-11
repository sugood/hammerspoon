require "modules/reload"
require "modules/hotkey"
require "modules/system"
require "modules/windows"
require "modules/launcher"
require "modules/snippet"

-- 监听~./hammerspoon/data/中的文件，如果有改变就自动更新
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/data", hs.reload):start()
