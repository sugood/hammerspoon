local chooser = require("hs.chooser")
local console = require("hs.console")

console.clearConsole()
local historyPath= "~/.hammerspoon/history.json"
local maxLength = 1000
local history = {}

function initData()
    if hs.json.read(historyPath) ~= nil then
        history = hs.json.read(historyPath)
    end
end
-- 初始化，读取本地数据
initData()
-- 查重
function duplicate(tablea,keys)
    for k,v in ipairs(tablea) do
        if v.text == keys then
            return true
        end
    end
    return false
end
-- 清除收尾空格
function trim(input)
    return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end
-- 字符串分割
string.split = function(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end
-- 添加片段到记录列表中
function addToHistory()
    local item = {}
    local str = hs.pasteboard.getContents()
    if str == nil then
        hs.alert.show("文本为空,请重新选择文本！")
    end
    local list = string.split(str, "|")
    if #list >1 then
        item.subText = trim(string.sub(str,#list[1]+2,string.len(str)))
        item.text = trim(list[1])
    else
        item.subText = trim(list[1])
        item.text = trim(list[1]) 
    end

    if duplicate(history, item.text) then
        hs.alert.show("片段已经存在")
        return
    end
    if #history >= maxLength then
        hs.alert.show("片段已超过："..maxLength.."个")
        return
    end
    table.insert(history, 1, item)
    -- 排序
    table.sort(history,function(a,b) return a.subText<b.subText end )

    hs.json.write(history,historyPath, true, true)
    hs.alert.show("成功添加片段："..item.text)
end
-- 按下添加快捷键时映射到复制快捷键
function bindCopyKey()
    hs.eventtap.keyStroke({ "cmd" }, "C")
end
-- 粘贴选中的片段
local completionFn = function(result)
    if result then
        hs.pasteboard.setContents(result.text)
        hs.eventtap.keyStroke({ "cmd" }, "V")
        print("keywords:"..result.text)
    end
end
-- 添加片段到记录列表中
function modifyHistory(text, subText, isText, index)
    if text and subText then
        if isText and duplicate(history, text) then
            hs.alert.show("片段已经存在")
            return
        end

        history[index].text = text
        history[index].subText = subText
        -- 排序
        table.sort(history,function(a,b) return a.subText<b.subText end )

        hs.json.write(history,historyPath, true, true)
        if isText then
            hs.alert.show("成功修改片段内容："..text)
        else
            hs.alert.show("成功修改片段说明："..subText)
        end
    else
        hs.alert.show("参数错误")
        return
    end
end
-- 右键弹出菜单
local menuFn = function(index)
    if index then
        menubar = hs.menubar.new(false)
        menubar:setTitle("Hidden Menu")
        menubar:setMenu( {
            { title = "菜单", fn = function() print("you clicked my menu item!") end },
            { title = "-" },
            { title = "修改片段内容", fn = function()
                result,text = hs.dialog.textPrompt("修改片段内容", "请输入新的内容", history[index].text, "确定", "取消")
                if result == "确定" then
                    modifyHistory(text,history[index].subText,true,index)
                end
            end },
            { title = "修改片段说明", fn = function()
                result,subText = hs.dialog.textPrompt("修改片段说明", "请输入新的说明", history[index].subText, "确定", "取消")
                if result == "确定" then
                    modifyHistory(history[index].text,subText,false,index)
                end
            end },
            { title = "-" },
            { title = "删除当前片段", fn = function()
                if hs.dialog.blockAlert("确定删除以下片段？",history[index].text,"确定","取消","informational") == "确定" then
                    table.remove(history,index)
                    hs.json.write(history,historyPath, true, true)
                    hs.alert.show("成功删除片段")
                end
            end },
        })
        menubar:popupMenu(hs.mouse.getAbsolutePosition(), true)
    else
        hs.alert.show("错误")
    end
end
-- 选取片段内容（按下快捷键时显示片段列表，点击选中的快捷键将自动粘贴）
hs.hotkey.bind({ "ctrl", "cmd" }, "V", function ()
    chooser.new(completionFn)
    :choices(history)
    :rightClickCallback(menuFn)
    :searchSubText(true)
    :show()
end)
-- 添加片段（按下快捷键时做一个复制操作，并记录复制的内容到片段列表中）
hs.hotkey.bind({"ctrl", "cmd"}, "A", function ()
    bindCopyKey()
    if hs.dialog.blockAlert("添加片段：‘|’为分隔符，建议按如下格式","内容|keyword|示例|说明","确定","取消","informational") == "确定" then
        addToHistory()
    end
end)
