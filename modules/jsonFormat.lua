-----
----- 格式化Json
----- Created by sugood(https://github.com/sugood).
----- DateTime: 2020/10/19 10:34
-----
--
--
function init()
    sheetView = nil
end

function initWeb()
    local cscreen = hs.screen.mainScreen()
    local cres = cscreen:fullFrame()
    sheetView = hs.webview.newBrowser({
        x = cres.x+cres.w*0.15/2,
        y = cres.y+cres.h*0.25/2,
        w = cres.w*0.85,
        h = cres.h*1.0
    })
    sheetView:deleteOnClose(true)
    sheetView:windowTitle("JsonFormat")
    sheetView:windowStyle("utility")
    sheetView:titleVisibility("hidden")
    sheetView:allowGestures(true)
    sheetView:allowNewWindows(true)
    sheetView:allowTextEntry(true)
    sheetView:closeOnEscape(true)
    sheetView:bringToFront(false)
    sheetView:darkMode(false)
    sheetView:reload(false)
    sheetView:shadow(true)
    sheetView:alpha(1)
    sheetView:level(hs.drawing.windowLevels.mainMenu) --设置窗口置顶
    sheetView:url("https://i.sugood.xyz/pages/jsonweb.html")
    sheetView:windowCallback(function(action, webview)
        if action == "closing" and not pickedDuration then
            sheetView = nil
        end
    end)
end

--- KSheet:hide()
--- Method
--- Hide the JsonFormat view.
function hide(time)
    --sheetView:hide(time)
    sheetView:delete()

    sheetView = nil
end

--- KSheet:show()
--- Method
--- Show JsonFormat.
function show(time)
    initWeb()
    bindCopyKey()
    local str = hs.pasteboard.getContents()
    -- local webcontent = generateHtml()
    -- sheetView:html(webcontent, "http://localhost")
    -- sheetView:url("https://i.sugood.xyz/pages/jsonweb.html")

    --print("窗口焦点"..hs.window.focusedWindow())
    sheetView:show(time)
    hs.focus()
    hs.timer.delayed.new(0.7, function() bindPasteKey() end):start()
    --bindPasteKey()
end

function toggle()
    if sheetView ~= nil and sheetView then
        hide(1)
    else
        show(1)
    end
end

init()

-- 按下添加快捷键时映射到复制快捷键
function bindCopyKey()
    hs.eventtap.keyStroke({ "cmd" }, "C")
end

function bindPasteKey()
    hs.eventtap.keyStroke({ "cmd" }, "V")
end

-- json 格式化
hs.hotkey.bind(hyperCmd, "G", function ()
    toggle()
end)
