---
--- 显示系统信息
--- 可显示CPU\内存\硬盘\网络等实时信息
--- Created by sugood(https://github.com/sugood).
--- DateTime: 2022/01/14 22:00
---

local menubaritem = hs.menubar.new()
local menuData = {}

-- ipv4Interface ipv6 Interface
local interface = hs.network.primaryInterfaces()

-- 该对象用于存储全局变量，避免每次获取速度都创建新的局部变量
local obj = {}

function init()
    if interface then
        local interface_detail = hs.network.interfaceDetails(interface)
        if interface_detail.IPv4 then
            local ipv4 = interface_detail.IPv4.Addresses[1]
            table.insert(menuData, {
                title = "IPv4:" .. ipv4,
                tooltip = "Copy Ipv4 to clipboard",
                fn = function()
                    hs.pasteboard.setContents(ipv4)
                end
            })
        end
        local mac = hs.execute('ifconfig ' .. interface .. ' | grep ether | awk \'{print $2}\'')
        table.insert(menuData, {
            title = 'MAC:' .. mac,
            tooltip = 'Copy MAC to clipboard',
            fn = function()
                hs.pasteboard.setContents(mac)
            end
        })
        table.insert(menuData, {
            title = 'Activity Monitor',
            tooltip = 'Show Activity Monitor',
            fn = function()
                bindActivityMonitorKey()
            end
        })
        table.insert(menuData, {
            title = 'Disk Utility',
            tooltip = 'Show Disk Utility',
            fn = function()
                bindDiskKey()
            end
        })

        obj.last_down = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $7}\'')
        obj.last_up = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $10}\'')
    end

    menubaritem:setMenu(menuData)
end

function scan()
    if interface then
        obj.current_down = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $7}\'')
        obj.current_up = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $10}\'')

        obj.cpu_used = getCpu()
        obj.disk_used = getRootVolumes()
        obj.mem_used = getVmStats()
        obj.down_bytes = obj.current_down - obj.last_down
        obj.up_bytes = obj.current_up - obj.last_up

        obj.down_speed = format_speed(obj.down_bytes)
        obj.up_speed = format_speed(obj.up_bytes)

        obj.display_text = hs.styledtext.new('▲ ' .. obj.up_speed .. '\n'..'▼ ' .. obj.down_speed , {font={size=9}, color={hex='#FFFFFF'}, paragraphStyle={alignment="left", maximumLineHeight=18}})
        obj.display_disk_text = hs.styledtext.new(obj.disk_used ..'\n'.. 'SSD ' , {font={size=9}, color={hex='#FFFFFF'}, paragraphStyle={alignment="left", maximumLineHeight=18}})
        obj.display_mem_text = hs.styledtext.new(obj.mem_used ..'\n'.. 'MEM ' , {font={size=9}, color={hex='#FFFFFF'}, paragraphStyle={alignment="left", maximumLineHeight=18}})
        obj.display_cpu_text = hs.styledtext.new(obj.cpu_used ..'\n'.. 'CPU ' , {font={size=9}, color={hex='#FFFFFF'}, paragraphStyle={alignment="left", maximumLineHeight=18}})

        obj.last_down = obj.current_down
        obj.last_up = obj.current_up

        local canvas = hs.canvas.new{x = 0, y = 0, h = 24, w = 30+30+30+60}
        -- canvas[1] = {type = 'text', text = obj.display_text}
        canvas:appendElements({
            type = "text",
            text = obj.display_cpu_text,
            -- withShadow = true,
            trackMouseEnterExit = true,
          },{
            type = "text",
            text = obj.display_disk_text,
            -- withShadow = true,
            trackMouseEnterExit = true,
            frame = { x = 30, y = "0", h = "1", w = "1", }
          },{
            type = "text",
            text = obj.display_mem_text,
            -- withShadow = true,
            trackMouseEnterExit = true,
            frame = { x = 60, y = "0", h = "1", w = "1", }
          },{
            type = "text",
            text = obj.display_text,
            -- withShadow = true,
            trackMouseEnterExit = true,
            frame = { x = 90, y = "0", h = "1", w = "1", }
          })
        menubaritem:setIcon(canvas:imageFromCanvas())
        canvas:delete()
        canvas = nil
    end
end

function format_speed(bytes)
    -- 单位 Byte/s
    if bytes < 1024 then
        return string.format('%6.0f', bytes) .. ' B/s'
    else
        -- 单位 KB/s
        if bytes < 1048576 then
            -- 因为是每两秒刷新一次，所以要除以 （1024 * 2）
            return string.format('%6.1f', bytes / 2048) .. ' KB/s'
            -- 单位 MB/s
        else
            -- 除以 （1024 * 1024 * 2）
            return string.format('%6.1f', bytes / 2097152) .. ' MB/s'
        end
    end
end

-- function showAllVolumes()
--     local vols = hs.fs.volume.allVolumes()
--     local msg = "volumes: \n"
--     for key, vol in pairs(vols) do
--         local size = vol.NSURLVolumeTotalCapacityKey
--         local free = vol.NSURLVolumeAvailableCapacityKey
--         msg = msg .. key .. 1-free/size.."\n"
--     end
--     return hs.alert(
--         msg,
--         {
--             ["textSize"] = 12
--         },
--         hs.screen.mainScreen(),
--         12
--     )
-- end

function getCpu()
    local data = hs.host.cpuUsage()
    local cpu = (data["overall"]["active"])
    return formatPercent(cpu)
end

function getVmStats()

    local vmStats = hs.host.vmStat()
    --1024^2
    local megDiv = 1048576
    local megMulti = vmStats.pageSize / megDiv

    local totalMegs = vmStats.memSize / megDiv  --总内存
    local megsCached = vmStats.fileBackedPages * megMulti   --缓存内存
    local freeMegs = vmStats.pagesFree * megMulti   --空闲内存

    --第一种方法使用 APP内存+联动内存+被压缩内存 = 已使用内存
    -- local megsUsed =  vmStats.pagesWiredDown * megMulti -- 联动内存
    -- megsUsed = megsUsed + vmStats.pagesUsedByVMCompressor * megMulti -- 被压缩内存
    -- megsUsed = megsUsed + (vmStats.pagesActive +vmStats.pagesSpeculative)* megMulti  -- APP内存

    --第二种方法使用 总内存-缓存内存-空闲内存 = 已使用内存
    local megsUsed = totalMegs - megsCached - freeMegs

    local usedMem = megsUsed/totalMegs * 100
    return formatPercent(usedMem)
end

function getRootVolumes()
    local vols = hs.fs.volume.allVolumes()
    for key, vol in pairs(vols) do
        local size = vol.NSURLVolumeTotalCapacityKey
        local free = vol.NSURLVolumeAvailableCapacityKey
        local usedSSD = (1-free/size) * 100
        if ( string.find(vol.NSURLVolumeNameKey,'Macintosh') ~= nil) then
            return formatPercent(usedSSD)
        end
    end
    return ' 0%'
end

function formatPercent(percent)
    if ( percent <= 0 ) then
        return "  1%"
    elseif ( percent < 10 ) then
        return "  " .. string.format("%.f", percent) .. "%"
    elseif  (percent > 99 )then
        return "100%"
    else
        return string.format("%.f", percent) .. "%"
    end
end

function resetSysInfoMeun()
    if(config ~=nil and config[1].showSysInfo == 'on' and menuBarItem:isInMenuBar() == false) then
        menuBarItem:delete()
        menuBarItem= hs.menubar.new()
        -- menuBarItem:setTitle("")
        -- menuBarItem:setIcon("~/.hammerspoon/icon/caffeine-on.pdf")
        --hs.caffeinate.set("displayIdle", true)
        -- queryCpu()
        init()
        scan()
        if obj.timer then
            obj.timer:stop()
            obj.timer = nil
        end
        -- 第三个参数表示当发生异常情况时，定时器是否继续执行下去
        obj.timer = hs.timer.doEvery(3, scan):start()
    else
        menuBarItem:delete()
    end
end

local setSysInfo= function()
    if config ~=nil and config[1].showSysInfo == 'on' and menuBarItem == nil then
        print("设置状态栏:系统信息")
        menuBarItem= hs.menubar.new()
        
        -- menuBarItem:setTitle("")
        -- menuBarItem:setIcon("~/.hammerspoon/icon/caffeine-on.pdf")
        -- queryCpu()
        init()
        scan()
        if obj.timer then
            obj.timer:stop()
            obj.timer = nil
        end
        -- 第三个参数表示当发生异常情况时，定时器是否继续执行下去
        obj.timer = hs.timer.doEvery(3, scan):start()
        
    -- else
    --     hs.caffeinate.set("displayIdle", false)
    end
end


function initData()
    setSysInfo()
    --监听系统信息开关的状态,判断是否要重置
    hs.timer.doEvery(1, resetSysInfoMeun)
    -- showAllVolumes()
end

-- 初始化
initData()

-- 按下添加快捷键时映射到活动监视器快捷键
function bindActivityMonitorKey()
    hs.eventtap.keyStroke({ "ctrl", "shift"}, "Q")
end
-- 按下添加快捷键时映射到磁盘工具快捷键
function bindDiskKey()
    hs.eventtap.keyStroke({ "ctrl", "shift"}, "D")
end