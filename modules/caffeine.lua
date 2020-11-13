---
--- 控制空闲时是否允许屏幕睡眠
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/24 14:13
---
local menuBarItem = nil
local setCaffeine= function()
    if config ~=nil and config[1].caffeine == 'on' and menuBarItem == nil then
        print("设置状态栏")
        menuBarItem= hs.menubar.new()
        menuBarItem:setTitle("")
        menuBarItem:setIcon("~/.hammerspoon/icon/caffeine-on.pdf")
        hs.caffeinate.set("displayIdle", true)
    else
        hs.caffeinate.set("displayIdle", false)
    end
end

function resetCaffeineMeun()
    if(config ~=nil and config[1].caffeine == 'on' and menuBarItem:isInMenuBar() == false) then
        print("重置状态栏")
        menuBarItem:delete()
        menuBarItem= hs.menubar.new()
        menuBarItem:setTitle("")
        menuBarItem:setIcon("~/.hammerspoon/icon/caffeine-on.pdf")
        --hs.caffeinate.set("displayIdle", true)
    end
end
function initData()
    setCaffeine()
    --监听咖啡因的状态,判断是否要重置
    hs.timer.doEvery(1, resetCaffeineMeun)
end
-- 初始化
initData()