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
        obj.last_down = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $7}\'')
        obj.last_up = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $10}\'')
    else
        obj.last_down =  0
        obj.last_down =  0
    end
    local date=os.date("%Y-%m-%d %a");
    table.insert(menuData, {
        title = 'Date: '..date,
        tooltip = 'Copy Now DateTime',
        fn = function()
            hs.pasteboard.setContents(os.date("%Y-%m-%d %H:%M:%S"))
        end
    })
    table.insert(menuData, {
        title = '打开:监  视  器    (⇧⌃A)',
        tooltip = 'Show Activity Monitor',
        fn = function()
            bindActivityMonitorKey()
        end
    })
    table.insert(menuData, {
        title = '打开:磁盘工具    (⇧⌃D)',
        tooltip = 'Show Disk Utility',
        fn = function()
            bindDiskKey()
        end
    })
    table.insert(menuData, {
        title = '打开:系统日历    (⇧⌃C)',
        tooltip = 'Show calendar',
        fn = function()
            bindCalendarKey()
        end
    })
    menubaritem:setMenu(menuData)
end

function scan()
    if interface then
        obj.current_down = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $7}\'')
        obj.current_up = hs.execute('netstat -ibn | grep -e ' .. interface .. ' -m 1 | awk \'{print $10}\'')
    else
        obj.current_down  = 0
        obj.current_up = 0
    end

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

function getCpu()
    local data = hs.host.cpuUsage()
    local cpu = (data["overall"]["active"])
    return formatPercent(cpu)
end

function getVmStats()

    local vmStats = hs.host.vmStat()
    -- --1024^2
    -- local megDiv = 1048576
    -- local megMulti = vmStats.pageSize / megDiv

    -- local totalMegs = vmStats.memSize / megDiv  --总内存
    -- local megsCached = vmStats.fileBackedPages * megMulti   --缓存内存
    -- local freeMegs = vmStats.pagesFree * megMulti   --空闲内存

    -- --第一种方法使用 APP内存+联动内存+被压缩内存 = 已使用内存
    -- --local megsUsed =  vmStats.pagesWiredDown * megMulti -- 联动内存
    -- --megsUsed = megsUsed + vmStats.pagesUsedByVMCompressor * megMulti -- 被压缩内存
    -- --megsUsed = megsUsed + (vmStats.pagesActive +vmStats.pagesSpeculative)* megMulti  -- APP内存

    -- --第二种方法使用 总内存-缓存内存-空闲内存 = 已使用内存
    -- local megsUsed = totalMegs - megsCached - freeMegs

    --第三种方法，由于部分设备pageSize获取不正确，所以只能通过已使用页数+缓存页数+空闲页数计算总页数
    local megsUsed =  vmStats.pagesWiredDown -- 联动内存
    megsUsed = megsUsed + vmStats.pagesUsedByVMCompressor -- 被压缩内存
    megsUsed = megsUsed + vmStats.pagesActive +vmStats.pagesSpeculative -- APP内存

    local megsCached = vmStats.fileBackedPages   --缓存内存
    local freeMegs = vmStats.pagesFree   --空闲内存

    local totalMegs = megsUsed + megsCached + freeMegs

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

local setSysInfo= function()
    if config ~=nil and config[1].showSysInfo == 'on' then
        if(menuBarItem ~= nil and menuBarItem:isInMenuBar() == false) then
            return
        end
        if (menuBarItem == nil) then
            print("设置状态栏:系统信息")
            menuBarItem= hs.menubar.new()
        elseif (menuBarItem:isInMenuBar() == false) then
            menuBarItem:delete()
            menuBarItem= hs.menubar.new()
        end
        init()
        scan()
        if obj.timer then
            obj.timer:stop()
            obj.timer = nil
        end
        -- 三秒刷新一次
        obj.timer = hs.timer.doEvery(3, scan):start()
    end
end


function initData()
    setSysInfo()
    --监听系统信息开关的状态,判断是否要重置
    hs.timer.doEvery(1, setSysInfo)
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
-- 按下添加快捷键时映射到日历快捷键
function bindCalendarKey()
    hs.eventtap.keyStroke({ "ctrl", "shift"}, "C")
end