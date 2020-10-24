-----
----- 格式化Json
----- Created by sugood(https://github.com/sugood).
----- DateTime: 2020/10/19 10:34
-----
--
--

local function generateHtml()

    local html = [[
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Json格式化高亮展示工具</title>

<style>
	body {  height: 100%; margin:0; font-family:"微软雅黑"; font-size:12px; }
    .pdiv { height: 85%; position: absolute; }
    .title { height: auto; font-size:20px; text-align:center; margin-top: 5px; margin-bottom: 20px;}
    .author { height: auto; width: 100%; font-size:12px; text-align:center; margin-top: 30px; margin-bottom: 20px;}
	table { height: 100%; width:100%; border-collapse:collapse;  }
	table .tdLeft { width:85%; text-align:left; padding-left: 10px;padding-right: 10px;}
    table .tdmid { width:150px; text-align:center; margin: 0px; padding: 0px;}
	table .tdRight { width:85%; padding-right: 30px;text-align:left; }
	table textarea { width:100%; height:100%; font-size:14px; padding-top: 10px; padding-left: 10px; outline: none; border-radius: 15px; border: 2px solid #8AC007; }
	#container { width:100%; height:100%; font-size:14px; padding-top: 10px; padding-left: 10px; border-radius: 15px; border: 2px solid #8AC007;}
    pre{white-space:pre-wrap; white-space:-moz-pre-wrap; white-space:-o-pre-wrap; word-wrap:break-word; margin: 0px; padding: 5px;}
    pre .string { color: green; }
    pre .number { color: darkorange; }
    pre .boolean { color: blue; }
    pre .null { color: magenta; }
    .key { color: red; }
</style>
</head>
<body>
    <div class="pdiv">
        <div class="title" >Json格式化高亮展示工具</div>
        <table style="table-layout:fixed">
            <tr>
                <!-- <td class="tdLeft" nowrap>请输入要展示的Json：</td> -->
                <td class="tdLeft">
                    <input style="width:auto; margin: 10px;" type="button" value="复制" onClick="copySource()">
                    <textarea name = "jsonContent" id="jsonContent" ></textarea>
                </td>
                <td class="tdmid"><input style="width:80%;" type="button" value="格式化JSON >>" onClick="showJson()"></td>
                <td class="tdRight">
                    <input style="width:auto; margin: 10px;" type="button" value="复制" onClick="copyResult()">
                    <pre id="container"></pre>
                </td>
            </tr>
        </table>
        <div class="author">
            <a href="https://github.com/sugood" target="_blank">By: github.com/sugood</a>
        </div>
        <div class="tips" id="tips">

        </div>
    </div>
</body>
<script type="text/javascript">

    function copySource(){
        var obj = document.getElementById('jsonContent');
        //选择当前对象
        obj.select();
        try{
            if(document.execCommand("Copy","false",null)){
                alert("复制成功！");
            }
        }catch(err){
            alert("复制错误！");
        }
    }

    function copyResult(){
        var text = document.getElementById('container').innerText;
        const input = document.createElement('textarea');
        input.value = text;
        input.setAttribute('readonly', 'readonly');
        document.body.appendChild(input);
        input.select();
        try{
            if(document.execCommand('Copy')){
                alert('复制成功');
            }
        }catch(err){
            alert("复制错误！");
        }
        document.body.removeChild(input);
    }

    function syntaxHighlight(json) {
        if (typeof json != 'string') {
            json = JSON.stringify(json, undefined, 4);
        }
        json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
            var cls = 'number';
            if (/^"/.test(match)) {
                if (/:$/.test(match)) {
                    cls = 'key';
                } else {
                    cls = 'string';
                }
            } else if (/true|false/.test(match)) {
                cls = 'boolean';
            } else if (/null/.test(match)) {
                cls = 'null';
            }
            return '<span class="' + cls + '">' + match + '</span>';
        });
    }

    function showJson(){
        var  text = document.getElementById('jsonContent').value
        if (text!="" && text!=null){
            try {
                var result = JSON.stringify(JSON.parse(text), null, 4);//将字符串转换成json对象
                highLineResult = syntaxHighlight(result);
                document.getElementById('container').innerHTML= highLineResult;
                localStorage.setItem("jsonFormatSource",text);
                localStorage.setItem("jsonFormatResult",highLineResult);
            } catch(e) {
                document.getElementById('container').innerText= '异常信息:'+e ;
            }
        }else{
            document.getElementById("jsonContent").value = "请输入json文本";
            document.getElementById('container').innerHTML= "显示Json格式化后的效果";
            localStorage.setItem("jsonFormatSource","请输入json文本");
            localStorage.setItem("jsonFormatResult","显示Json格式化后的效果");
        }
　　};

    var jsonFormatSource = localStorage.getItem("jsonFormatSource");
    if (jsonFormatSource!="" && jsonFormatSource!=null){
        document.getElementById("jsonContent").value=localStorage.getItem("jsonFormatSource");
    }else{
        document.getElementById("jsonContent").value = "请输入json文本"
    }
    var jsonFormatResult = localStorage.getItem("jsonFormatResult");
    if (jsonFormatResult!="" && jsonFormatResult!=null){
        document.getElementById("container").innerHTML=localStorage.getItem("jsonFormatResult");
    }else{
        document.getElementById("jsonContent").value = "显示Json格式化后的效果"
    }

</script>
</html>
        ]]

    return html
end


--- KSheet:hide()
--- Method
--- Hide the cheatsheet view.
function hide(time)
    sheetView:hide(time)
end

function init()
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

--- KSheet:show()
--- Method
--- Show current application's keybindings in a view.
function show(time)
    local webcontent = generateHtml()
    sheetView:html(webcontent, "http://localhost")
    sheetView:show(time)
end

function toggle()
    if sheetView and sheetView:hswindow() and sheetView:hswindow():isVisible() then
        hide(2)
    else
        show(2)
    end
end

init()

-- 添加片段（按下快捷键时做一个复制操作，并记录复制的内容到片段列表中）
hs.hotkey.bind(hyperCmd, "G", function ()
    toggle()
end)
