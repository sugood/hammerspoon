hs.configdir = os.getenv('HOME') .. '/.hammerspoon'
package.path = hs.configdir .. '/?.lua;' .. hs.configdir .. '/?/init.lua;' .. hs.configdir .. '/Spoons/?.spoon/init.lua;' .. package.path

require "modules/reload"
require "modules/commons"
require "modules/hotkey"
require "modules/system"
require "modules/windows"
require "modules/launcher"
require "modules/snippet"
require "modules/timesync"
require "modules/caffeine"
require "modules/inputstat"
require "modules/dict"
require "modules/jsonFormat"

