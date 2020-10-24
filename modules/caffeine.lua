---
--- 控制空闲时是否允许屏幕睡眠
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/24 14:13
---

if config ~=nil and config[1].caffeine == 'on' then
    print("设置状态栏")
    local menuBarItem = hs.menubar.new()
    menuBarItem:setTitle("")
    menuBarItem:setIcon("~/.hammerspoon/icon/caffeine-on.pdf")
    hs.caffeinate.set("displayIdle", true)
else
    hs.caffeinate.set("displayIdle", false)
end

