---
--- 时间同步，开启后在系统或屏幕唤醒后自动同步一次时间
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/23 11:12
---

function execTimeSync()
    local shell_command = 'expect ~/.hammerspoon/timesync/timesync.sh '.. config[1].rootPassword
    result = table.pack(hs.execute(shell_command,true))
    print(result[1])
end
function caffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidSleep) then
      print("screensDidSleep")
    elseif (eventType == hs.caffeinate.watcher.screensDidWake) then
        execTimeSync()
        hs.reload()
      print("screensDidWake")
    elseif (eventType == hs.caffeinate.watcher.systemDidWake) then
        execTimeSync()
        hs.reload()
        print("systemDidWake")
    elseif (eventType == hs.caffeinate.watcher.screensDidLock) then
      print("screensDidLock")
    elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
      print("screensDidUnlock")
    end
end

function initData()
    if config ~=nil and config[1].isSyncTime == 'on' then
        caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
        caffeinateWatcher:start()

        -- 添加片段（按下快捷键时做一个复制操作，并记录复制的内容到片段列表中）
        hs.hotkey.bind(hyperCmd, "T", function ()
            if hs.json.read(configPath) ~= nil then
                config = hs.json.read(configPath)
            end
            if(stringIsEmpty(config[1].rootPassword)) then
                local result,subText = hs.dialog.textPrompt("输入开机密码", "时间同步操作需要开机密码", '', "确定", "取消", true)
                if result == "确定" then
                    if(stringIsEmpty(subText) == false) then
                        config[1].rootPassword = subText
                        hs.json.write(config,configPath, true, true)
                        execTimeSync()
                        hs.alert.show('同步时间')
                    end
                end
            else
                execTimeSync()
                hs.alert.show('同步时间')
            end
        end)
    end
end
-- 初始化，读取本地数据
initData()

