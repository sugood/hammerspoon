---
--- 在状态栏中显示输入法的状态
--- 例如：大小写状态，中英文状态，目前只适配搜狗输入法
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/24 11:12
---

local sougouId = 'com.sogou.inputmethod.sogou.pinyin'
local shuangpinId = 'com.apple.inputmethod.SCIM.Shuangpin'
local abcId = 'com.apple.keylayout.ABC'

local mEventtap
function isChinese()
    -- 用于保存当前输入法
    local currentSourceID = hs.keycodes.currentSourceID()
    return (currentSourceID == sougouId or currentSourceID == shuangpinId)
end

--解决hs.eventtap.new 有时候会卡死的问题。需要每秒检查下监听状态。如果卡死了就重新启动
local listenerEvent = function()
    if mEventtap:isEnabled()==false then
        print("重启监听事件")
        mEventtap:start()
    end
end
function initData()
    local reverse = true
    local imgInputAbc = '~/.hammerspoon/icon/input_abc.pdf'
    local imgInputEn = '~/.hammerspoon/icon/input_en.pdf'
    local imgInputCn = '~/.hammerspoon/icon/input_cn.pdf'
    local imgInputU = '~/.hammerspoon/icon/input_u.pdf'

    --初始化默认是英文输入法
    hs.keycodes.currentSourceID(abcId)
    if hs.hid.capslock.get() then
        macMenubar:setIcon(imgInputU)
    else
        if(isChinese()) then
            macMenubar:setIcon(imgInputCn)
        else
            macMenubar:setIcon(imgInputAbc)
        end
    end
    mEventtap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
        --获取shift按键信息
        if event:getKeyCode() == 56  and event:getFlags().shift then
            if (isChinese()) then
                hs.hid.led.set('caps',false)
                hs.alert.closeSpecific(showUUID)
                if reverse then
                    reverse = false
                    macMenubar:setIcon(imgInputEn)
                else
                    reverse = true
                    macMenubar:setIcon(imgInputCn)
                end
            else
                if hs.hid.capslock.get()==false then
                    reverse = false
                    macMenubar:setIcon(imgInputAbc)
                end
            end
            return
        end
        --获取capslock按键信息
        tab =hs.eventtap.checkKeyboardModifiers("capslock")
        local isCaptLock = tab["capslock"]
        if isCaptLock then
            if hs.hid.capslock.get() then
                hs.hid.led.set('caps',true)
            else
                hs.hid.led.set('caps',false)
                hs.alert.closeAll(0)
                hs.alert.show("键盘小写 🔤- OFF")
                if(isChinese()) then
                    if(reverse) then
                        macMenubar:setIcon(imgInputCn)
                    else
                        macMenubar:setIcon(imgInputEn)
                    end
                else
                    macMenubar:setIcon(imgInputAbc)
                end
            end
        else
            if hs.hid.capslock.get() then
                hs.hid.led.set('caps',true)
                hs.alert.closeAll(0)
                hs.alert.show("键盘大写 🅰️- ON")
                macMenubar:setIcon(imgInputU)
            else
                --print("小写2")
                hs.hid.led.set('caps',false)
            end
        end
        return false
    end)
    mEventtap:start()
    hs.timer.doEvery(1, listenerEvent)  --有BUG,经常假死
    hs.keycodes.inputSourceChanged(function()
        --resetCaffeineMeun()
        --切换输入法后查询下监听状态
        listenerEvent()
        -- 用于保存当前输入法
        local currentSourceID = hs.keycodes.currentSourceID()

        -- 如果当前输入法和上一个输入法相同，则直接返回
        if currentSourceID == lastSourceID then
            return
        end
        -- 用于保存当前输入法
        local currentSourceID = hs.keycodes.currentSourceID()
        hs.alert.closeAll(0)
        -- 判断是系统自带的 ABC还是中文输入法
        if (currentSourceID == abcId) then
            --hs.alert.show("ABC")
            macMenubar:setIcon(imgInputAbc)
            reverse = false
        elseif (currentSourceID == sougouId or currentSourceID == shuangpinId) then
            --hs.alert.show("中文")
            reverse = true
            macMenubar:setIcon(imgInputCn)
        end
        -- 保存最后一个输入法源名称ds
        lastSourceID = currentSourceID
    end)
end
-- 初始化
initData()


