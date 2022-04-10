# 语言切换

- en [English](README_en.md)
- zh_CN [简体中文](README.md)
  
# 运行环境要求
已测试可用的系统：MacOS 10.14 及以上


# 脚本功能说明

已完成如下功能

1. 状态栏显示输入法状态
2. 时间同步功能
3. 屏幕取色功能
4. JSON格式化功能
5. 翻译功能（支持百度和有道API）
6. 咖啡因（设置系统永不睡眠）
7. 备忘录功能
8. 状态栏显示系统信息（CPU/内存/硬盘/网速）
9. 窗口管理
10. 快捷键快速启动其他应用
<!-- more -->

# 此脚本的优势

本脚本相当于整合了多个APP的功能。对比如下


- 与Captin/Capsee 等APP能显示大小写状态相比，本工具除了在切换大小写时显示还能在状态栏中显示大小写状态，这样一些没有大小写指示灯的键盘可以很方便的查看当前的大小写状态

- 屏幕取色功能 替换其他各种屏幕取色APP

- 对比各种JSON格式化网页，本工具能通过快键键便捷打开界面，而且不用拉起任何浏览器。

- 与各种翻译APP对比，本工具的功能更加纯粹，而且通过快捷键能快速的进行翻译,右键对译文或者原文进行朗读

- 对比通过系统电池设置屏幕常亮需要麻烦的操作，本工具的咖啡因功能，可以一键切换屏幕常亮和普通模式

- 对比iStat Menus等显示系统状态栏信息的APP,本工具会更节省显示状态栏空间而且还是免费的

- 窗口管理功能通过快捷键方便的分屏，移动窗口，移动光标等

- 通过快捷键快速启动系统或第三方应用，目前默认配置了9个应用的启动快键键


# Hammerspoon 配置
## 使用方法
### 如何安装
1. 下载安装 [Hammerspoon](https://github.com/Hammerspoon/hammerspoon/releases)。确保是在0.9.81 版本及以上，github速度有点慢请耐心等待~
2. 如果已经存在~/.hammerspoon文件夹请先删除。然后克隆当前项目到~/.hammerspoon中
3. 运行Hammerspoon，提示需要辅助功能权限，请允许。
4. 如果需要开机启动，请在设置界面勾选 Launch Hammerspoon at login选项进行设置

![paste image](http://imgs.sugood.xyz/16423883845396qcfy0u9.png?imageslim)

### 如何更新
1. 在终端中执行以下两条指令

```bash
# 打开Hammerspoon配置文件夹
cd ~/.hammerspoon
#拉取执行的更新
git pull origin master
```
2. 点击hammerspoon的 reload config 更新配置文件


# 功能详细说明
## 快捷键图标
|           |  键位           |
| --------- | -------------- |
| <kbd>⇧</kbd> | Shift       |
| <kbd>⌃</kbd> | Control   	 |
| <kbd>⌥</kbd> | Option 		 |
| <kbd>⌘</kbd> | Command   	 |

## 功能
### 状态栏显示输入法状态
1. 界面如下

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201025120715361.gif#pic_center)

2.功能说明

可显示大小写状态，输入法状态，中英文状态。目前仅测试过搜狗输入法

### 片段和备忘录

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>X</kbd> 添加一个片段或者备忘
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>V</kbd> 列出片段或备忘录并使用

### JSON格式化

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>G</kbd> JSON格式化

#### 界面与功能说明
1. 界面如下

![paste image](http://imgs.sugood.xyz/1642388815070fcmlt9bk.png?imageslim)

*ps:第一次使用请先右键左边的窗口，将substitutions -> smart Quotas的勾选去掉。这个功能会自动补全一些字符，如果有中文会出现错误，所以要关掉。*

2. 功能入下
 - 实现了json格式化功能
 - json代码高亮
 - 可搜素
 - json转XML
 - json转CSV
 - json转YAML
 
### 自动同步时间
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>T</kbd> 自动同步时间
#### 界面与功能说明
1. 界面如下

![paste image](http://imgs.sugood.xyz/16423890298911k5gbron.png?imageslim)

*ps:该功能默认是关闭的，如需使用先给mac安装expect，并在上图的位置输入开机密码。一般情况下mac的时间同步都是没问题的。但是像我的黑苹果睡眠唤醒后时间不准的，已确保Bios电池没问题，也重新设置了系统的时间同步服务器都没解决。还有些人的电脑用了一段时间后时间就会不准的。可以尝试使用这个功能*

1. 功能说明
- 使用国内阿里的时间同步服务器 ntp.aliyun.com 。稳定性好
- 在系统或屏幕唤醒时才同步一次。不使用定时任务，而是监听系统状态来进行时间同步。所以，不用担心一直消耗系统资源。

### 翻译
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> 翻译

1. 功能说明
- 默认使用百度翻译，可设置自己的百度或有道API进行翻译
- 使用MacOS TTS功能，对译文或者原文进行朗读

#### 界面与功能说明
界面

1. 设置说明

支持百度和有道翻译API。百度翻译可直接使用。有道翻译需要先申请有道翻译API并配置appKey和appSecret

![paste image](http://imgs.sugood.xyz/16423890683344ptjvyx2.png?imageslim)
2. 界面如下
![paste image](http://imgs.sugood.xyz/1642389116871k7d7xxcu.png?imageslim)

![paste image](http://imgs.sugood.xyz/16423891493741fvfyb5p.png?imageslim)
3. 功能说明
- 支持百度翻译API和有道翻译API双引擎切换。百度翻译API使用的是我个人的账户。大家可以直接使用，不想用我的也可以自己注册然后再修改appkey和appsecret即可。有道翻译一定要自己去注册api。新用户注册有50块的体验金，用完就要收费了
- 可打开网页详情
- 可保存数据到本地，下次打开还能显示上次的结果
- 如果翻译的文字很长。可以点击右键查看详情或者是进入网页查看详情
### 屏幕取色功能
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>P</kbd> 打开取色器
1. 界面如下

![paste image](http://imgs.sugood.xyz/1642389183172fq3h28sb.png?imageslim)

2. 功能说明
菜单栏点击屏幕取色，出现取色界面后点击颜色拾取器，就可以获取当前屏幕鼠标所在位置的颜色值

### 咖啡因

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>S</kbd> 咖啡因开关

1. 界面如下

![paste image](http://imgs.sugood.xyz/1642389211527sub01we5.png?imageslim)


2. 功能说明
菜单栏点击“咖啡因”打开系统永不休眠功能，打开后状态栏会出现一个咖啡杯的图标，再点击一次就能关闭，状态栏的咖啡杯图标也会消失


### 状态栏显示系统状态
1. 界面如下

![paste image](http://imgs.sugood.xyz/164238938310916oczrix.png?imageslim)

![paste image](http://imgs.sugood.xyz/1642389420165loks26qg.png?imageslim)

![paste image](http://imgs.sugood.xyz/1642390044792e1nmpyoy.png?imageslim)
2. 功能说明

菜单栏点击-“系统状态”打开状态栏显示系统状态信息的显示，再点击一次可关闭状态栏显示


### 窗口管理

#### 1/2 屏幕

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>←</kbd> 将当前窗口移动到左半屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>→</kbd> 将当前窗口移动到右半屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>↑</kbd> 将当前窗口移动到上半屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>↓</kbd>	将当前窗口移动到下半屏

#### 1/4 屏幕

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>←</kbd> 将当前窗口移动到左上 1/4 屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>→</kbd> 将当前窗口移动到右下 1/4 屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>↑</kbd> 将当前窗口移动到右上 1/4 屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>↓</kbd> 将当前窗口移动到左下 1/4 屏

#### 多个显示器

##### 移动光标

* <kbd>⌃</kbd><kbd>⌥</kbd> + <kbd>←</kbd> 把光标移动到下一个显示器
* <kbd>⌃</kbd><kbd>⌥</kbd> + <kbd>→</kbd> 把光标移动到上一个显示器

##### 移动窗口

* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>←</kbd> 将当前活动窗口移动到上一个显示器
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>→</kbd> 将当前活动窗口移动到下一个显示器
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>1</kbd> 将当前活动窗口移动到第一个显示器并窗口最大化
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>2</kbd> 将当前活动窗口移动到第二个显示器并窗口最大化


#### 其它

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> 全屏
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>M</kbd> 最大化窗口
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>C</kbd> 将窗口放到中间
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>H</kbd>  切换活动窗口
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>/</kbd>  显示窗口切换的快捷键

### 系统工具

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>L</kbd> 锁屏

### 快速启动

* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>A</kbd> `Launchpad`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>C</kbd> `calendar`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>D</kbd> `Disk Utility`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>E</kbd> `Finder`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>G</kbd> `Google Chrome`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Q</kbd> `Activity Monitor`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>T</kbd> `Terminal`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>S</kbd> `System Preferences`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Z</kbd> `Calculator`
