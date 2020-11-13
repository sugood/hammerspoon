---
--- 公共函数
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/24 14:13
---
local console = require("hs.console")
version = "v0.1.2"
configPath= "~/.hammerspoon/data/config.json"
initConfigPath= "~/.hammerspoon/data/initConfig.json"
config = {}
colorDialog = hs.dialog.color

--检查文件是否存在
function checkFileExist(path)
    local file = hs.fs.pathToAbsolute(path)
    return file ~= nil
end

--复制文件
function copyFile(source,destination)
    print(destination)
    local sourcefile = io.open(source, "r")
    local destinationfile = io.open(destination, "w")
    destinationfile:write(sourcefile:read("*all"))
    sourcefile:close()
    destinationfile:close()
end

function switchDict()
    if config[1].dictEngine == '百度' then
        config[1].dictEngine = '有道'
    else
        config[1].dictEngine = '百度'
    end
    hs.json.write(config,configPath, true, true)
    hs.reload()
end

function switchTime()
    if config[1].isSyncTime == 'on' then
        config[1].isSyncTime = 'off'
    else
        if(stringIsEmpty(config[1].rootPassword)) then
            local result,subText = hs.dialog.textPrompt("输入开机密码", "时间同步操作需要开机密码", '', "确定", "取消", true)
            if result == "确定" and stringIsEmpty(subText) == false then
                config[1].rootPassword = subText
                config[1].isSyncTime = 'on'
            end
        else
            config[1].isSyncTime = 'on'
        end
    end
    hs.json.write(config,configPath, true, true)
    hs.reload()
end

function switchCaffeine()
    if config[1].caffeine == 'on' then
        config[1].caffeine = 'off'
    else
        config[1].caffeine = 'on'
    end
    hs.json.write(config,configPath, true, true)
    hs.reload()
end

--设置全局菜单栏
function initMenu()
    macMenubar = hs.menubar.new()
    macMenubar:setTitle("")
    macMenubar:setIcon()
    macMenubar:setMenu( {
        { title = "Reload config", fn = function()
            hs.reload()
        end },
        { title = "Open console", fn = function() hs.openConsole() end },
        { title = "Relaunch", fn = function() hs.relaunch() end },
        { title = "-" },
        { title = "翻译平台：" .. config[1].dictEngine, fn = function()
            if (hs.dialog.blockAlert("支持百度和有道翻译，确认切换？","有道翻译需先申请有道云API","确定","取消","informational") == "确定") then
                switchDict()
            end
        end },
        { title = "输入appID", fn = function()
            if(config[1].dictEngine == '有道') then
                local result,subText = hs.dialog.textPrompt("输入appID", "请通过有道云API获取appkey", config[1].youdaoAppid, "确定", "取消", false)
                if result == "确定" then
                    config[1].youdaoAppid = subText
                    hs.json.write(config,configPath, true, true)
                end
            elseif(config[1].dictEngine == '百度') then
                local result,subText = hs.dialog.textPrompt("输入appID", "百度翻译可不修改", config[1].baiduAppid, "确定", "取消", true)
                if result == "确定" then
                    config[1].baiduAppid = subText
                    hs.json.write(config,configPath, true, true)
                end
            end
        end },
        { title = "输入appSecret", fn = function()
            if(config[1].dictEngine == '有道') then
                local result,subText = hs.dialog.textPrompt("输入appSecret", "请通过有道云API获取appSecret", config[1].youdaoAppSecret, "确定", "取消", false)
                if result == "确定" then
                    config[1].youdaoAppSecret = subText
                    hs.json.write(config,configPath, true, true)
                end
            elseif(config[1].dictEngine == '百度') then
                local result,subText = hs.dialog.textPrompt("输入appSecret", "百度翻译可不修改", config[1].baiduAppSecret, "确定", "取消", true)
                if result == "确定" then
                    config[1].baiduAppSecret = subText
                    hs.json.write(config,configPath, true, true)
                end
            end
        end },
        { title = "-" },
        { title = "时间同步：" .. config[1].isSyncTime, fn = function()
            switchTime()
        end },
        { title = "输入开机密码", fn = function()
            local result,subText = hs.dialog.textPrompt("输入开机密码", "时间同步操作需要开机密码", config[1].rootPassword, "确定", "取消", true)
            if result == "确定" then
                config[1].rootPassword = subText
                hs.json.write(config,configPath, true, true)
            end
        end },
        { title = "-" },
        { title = "屏幕取色", fn = function()
            hs.openConsole(true)
            colorDialog.show()
            colorDialog.mode("RGB")
            colorDialog.callback(function(a,b)
                if b then
                    hs.closeConsole()
                end
            end)
            hs.closeConsole()
        end },
        { title = "-" },
        { title = "咖啡因：" .. config[1].caffeine, fn = function()
            switchCaffeine()
        end },
        { title = "-" },
        { title = "打开键盘偏好设置", fn = function() hs.osascript.applescript([[
            tell application "System Preferences"
            reveal anchor "InputSources" of pane "com.apple.preference.keyboard"
            activate
            end tell ]]
        ) end },
        { title = "-" },
        { title = "关于", fn = function()
            if (hs.dialog.blockAlert("当前版本："..version,"整理了一些能够提高效率的脚本，打开主页查看详细说明。","确定","取消","informational") == "确定") then
                hs.urlevent.openURL("https://github.com/sugood/hammerspoon")
            end
        end },
    })
end

function initData()
    --第一次安装需要复制一个配置文件。以后更新则不会修改用户配置文件，防止被覆盖
    if(checkFileExist(configPath) == false) then
        print("初始化配置文件")
        --获取绝对路径，io.open只支持绝对路径
        local source = hs.fs.pathToAbsolute(initConfigPath)
        local destination = string.gsub(source, "initConfig.json$", "config.json")
        copyFile(source,destination)
    end

    if hs.json.read(configPath) ~= nil then
        config = hs.json.read(configPath)
    end
    initMenu()
    -- 修改全局alert样式
    hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
    hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
    hs.alert.defaultStyle.radius =  10
    --清空打印信息
    console.clearConsole()
    --
    colorDialog.mode("RGB")
end

initData()

-- 字符串判空
function stringIsEmpty(str)
    return str == nil or str == ''
end

--生成url编码
function decodeURI(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

--截取UTF8字符
function SubStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
    end

    if endIndex == nil then
        return string.sub(str, SubStringGetTrueIndex(str, startIndex));
    else
        return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end

--获取中英混合UTF8字符串的真实字符数量
function SubStringGetTotalIndex(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

function SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end

--返回当前字符实际占用的字符数
function SubStringGetByteCount(str, index)
    local curByte = string.byte(str, index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount;
end

--判断是否复制成功
function isCopySuccess()
    local num = hs.pasteboard.changeCount()
    print("复制前数量："..num)
    hs.eventtap.keyStroke({ "cmd" }, "C")
    local numAfter = hs.pasteboard.changeCount()
    print("复制后数量："..numAfter)
    return numAfter > num
end