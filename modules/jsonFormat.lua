-----
----- 格式化Json
----- Created by sugood(https://github.com/sugood).
----- DateTime: 2020/10/19 10:34
-----
--
--

function init()
    local cscreen = hs.screen.mainScreen()
    local cres = cscreen:fullFrame()
    sheetView = hs.webview.newBrowser({
        x = cres.x+cres.w*0.15/2,
        y = cres.y+cres.h*0.25/2,
        w = cres.w*0.85,
        h = cres.h*1.0
    })
    sheetView:windowTitle("JsonFormat")
    sheetView:windowStyle("utility")
    sheetView:titleVisibility("hidden")
    sheetView:allowGestures(true)
    sheetView:allowNewWindows(true)
    sheetView:allowTextEntry(true)
    sheetView:closeOnEscape(true)
    sheetView:bringToFront(false)
    sheetView:darkMode(true)
    sheetView:reload(false)
    sheetView:shadow(true)
    sheetView:alpha(1)
    sheetView:level(hs.drawing.windowLevels.mainMenu)
    sheetView:url("https://i.sugood.xyz/pages/jsonweb.html")
end

--- KSheet:hide()
--- Method
--- Hide the JsonFormat view.
function hide(time)
    sheetView:hide(time)
end

--- KSheet:show()
--- Method
--- Show JsonFormat.
function show(time)
    bindCopyKey()
    local str = hs.pasteboard.getContents()
    -- local webcontent = generateHtml()
    -- sheetView:html(webcontent, "http://localhost")
    -- sheetView:url("https://i.sugood.xyz/pages/jsonweb.html")
    sheetView:show(time)
end

function toggle()
    if sheetView and sheetView:hswindow() and sheetView:hswindow():isVisible() then
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
-- 添加片段（按下快捷键时做一个复制操作，并记录复制的内容到片段列表中）
hs.hotkey.bind(hyperCmd, "G", function ()
    toggle()
end)
