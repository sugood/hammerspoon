---
--- 快速打开翻译，支持百度和有道翻译API
--- 有道API需要用户自行申请。
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2020/10/23 11:12
---


local chooser = require("hs.chooser")
local menubar = hs.menubar.new()
local dictHistoryPath= "~/.hammerspoon/data/dictHistory.json"
local ydUrl = 'https://openapi.youdao.com/api'
local bdUrl = 'https://fanyi-api.baidu.com/api/trans/vip/translate'
local bdWeburl = 'https://fanyi.baidu.com/#'
local ydWeburl = 'http://youdao.com/w/'

local mChooser
local searchResult = {}
local isFirst = true
function truncate(q)
    if q == nil or q == '' then
        return ''
    end
    local len = SubStringGetTotalIndex(q)
    if (len <= 20) then
        return q
    else
        return SubStringUTF8(q,1,10)..len..SubStringUTF8(q,len-9)
    end
end

function newWebview()
    local cscreen = hs.screen.mainScreen()
    local cres = cscreen:fullFrame()
    sheetView = hs.webview.newBrowser({
        x = cres.x+cres.w*0.15/2,
        y = cres.y+cres.h*0.25/2,
        w = cres.w*0.85,
        h = cres.h*0.75
    })
    sheetView:windowTitle("CheatSheets")
    sheetView:windowStyle("utility")
    sheetView:titleVisibility("hidden")
    sheetView:allowGestures(true)
    sheetView:allowNewWindows(false)
    sheetView:allowTextEntry(true)
    sheetView:closeOnEscape(true)
    sheetView:bringToFront(false)
    sheetView:darkMode(true)
    sheetView:reload(false)
    sheetView:level(hs.drawing.windowLevels.mainMenu)
end

-- 右键弹出菜单
local rightClickCallbackFn = function(index)
    if index and index > 0 then
        local selectResult = mChooser:selectedRowContents(index)
        if selectResult == nil or stringIsEmpty(selectResult.text) then
            return
        end
        menubar = hs.menubar.new(false)
        menubar:setTitle("Hidden Menu")
        menubar:setMenu( {
            { title = "查看详情", fn = function()
                hs.dialog.blockAlert(selectResult.text, selectResult.subText,"确定","","informational")
            end },
            { title = "查看网页", fn = function()
                sheetView:url(selectResult.webUrl):show()
            end },
        })
        menubar:popupMenu(hs.mouse.getAbsolutePosition(), true)
    end
end

function getBaiduApi(q)
    headers = {ContentType = "application/x-www-form-urlencoded;charset=utf-8"}
    salt = tostring(hs.timer.secondsSinceEpoch()*1000)
    curtime = tostring(os.time())
    geturl = "q="..q.."&from=auto&to=auto&appid=".. config[1].baiduAppid .."&salt="..salt.."&sign="..hs.hash.MD5(config[1].baiduAppid ..q..salt..config[1].baiduAppSecret)
    --print('geturl:'..geturl)

    hs.http.doAsyncRequest(bdUrl,'POST',geturl,headers,function(code, body, htable)
     if code ~= 200 then
         print('get weather error:'..code)
         return
     else
         searchResult = {}
         results = hs.json.decode(body)
         print('results:'..hs.inspect(results))
         if(results['trans_result']) then
             item = {}
             item.text = results['trans_result'][1].dst
             item.subText = q
             item.webUrl = bdWeburl..results['from'].."/"..results['to'].."/"..decodeURI(q)
             table.insert(searchResult,1,item)
         end
         mChooser:choices(searchResult)
         hs.json.write(searchResult,dictHistoryPath, true, true)
     end
    end)
end

function getYoudaoApi(q)
    headers = {ContentType = "application/x-www-form-urlencoded;charset=utf-8"}
    salt = tostring(hs.timer.secondsSinceEpoch()*1000)
    curtime = tostring(os.time())
    geturl = "q="..q.."&from=auto&to=auto&signType=v3&curtime="..curtime.."&appKey="..config[1].youdaoAppid..
            "&salt="..salt.."&sign="..hs.hash.SHA256(config[1].youdaoAppid..truncate(q)..salt..curtime..config[1].youdaoAppSecret)
    --print('geturl:'..geturl)

    hs.http.doAsyncRequest(ydUrl,'POST',geturl,headers,function(code, body, htable)
        if code ~= 200 then
            print('get weather error:'..code)
            return
        else
            searchResult = {}
            results = hs.json.decode(body)
            --print('results:'..hs.inspect(results))
            if(results['web']) then
                --逆序插入
                for i=#results['web'],1,-1 do
                    item = {}
                    item.text = table.concat(results['web'][i].value,", ")
                    item.subText = results['web'][i].key
                    item.webUrl = ydWeburl..decodeURI(item.subText)
                    table.insert(searchResult,1,item)
                end
            end
            if(results['basic']) then
                if (results['basic']['exam_type']) then
                    item = {}
                    item.text = table.concat(results['basic']['exam_type'],', ')
                    item.subText = q
                    item.webUrl = ydWeburl..decodeURI(item.subText)
                    table.insert(searchResult,1,item)
                end
                if (results['basic']['explains']) then
                    for i=#results['basic']['explains'],1,-1 do
                        item = {}
                        item.text = results['basic']['explains'][i]
                        item.subText = q
                        item.webUrl = ydWeburl..decodeURI(item.subText)
                        table.insert(searchResult,1,item)
                    end

                end
            end
            if(results['translation']) then
                item = {}
                item.text = table.concat(results['translation'])
                item.subText = q
                item.webUrl = ydWeburl..decodeURI(item.subText)
                table.insert(searchResult,1,item)
            end
            mChooser:choices(searchResult)
            hs.json.write(searchResult,dictHistoryPath, true, true)
        end
    end)
end
-- 粘贴选中的片段
local completionFn = function(result)
    if result then
        hs.pasteboard.setContents(result.text)
        --hs.eventtap.keyStroke({ "cmd" }, "V")
        print("keywords:"..result.text)
    end
end
-- 监听输入框
local queryChangedCallbackFn = function(result)
    print("changekeywords:"..result)
    if result and #result > 0 then
        if config[1].dictEngine == '百度' then
            getBaiduApi(result)
        else
            getYoudaoApi(result)
        end
    else
        if(isFirst) then
            isFirst = false
        else
            searchResult = {}
            mChooser:choices(searchResult)
            hs.json.write(searchResult,dictHistoryPath, true, true)
        end
    end
end

function initData()
    newWebview()
    -- 选取片段内容（按下快捷键时显示片段列表，点击选中的快捷键将自动粘贴）
    hs.hotkey.bind(hyperCmd, "F", function ()
        isFirst = true
        if hs.json.read(dictHistoryPath) ~= nil then
            searchResult = hs.json.read(dictHistoryPath)
        end
        local num = hs.pasteboard.changeCount()
        hs.eventtap.keyStroke({ "cmd" }, "C")
        mChooser = chooser.new(completionFn)
                          :choices(searchResult)
                          :queryChangedCallback(queryChangedCallbackFn)
                          :rightClickCallback(rightClickCallbackFn)
                          :searchSubText(true)
                          :show()
        local numAfter = hs.pasteboard.changeCount()
        --如果复制成功则自动查询复制的内容，否者只打开翻译界面
        if(numAfter > num) then
            --粘贴选中的文本进行查询
            hs.eventtap.keyStroke({ "cmd" }, "V")
        end
    end)
end

initData()