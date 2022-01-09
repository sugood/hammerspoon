# Hammerspoon 配置

## 使用方法

1. 安装 [Hammerspoon](http://www.hammerspoon.org/)
2. `git clone https://github.com/sugood/hammerspoon.git ~/.hammerspoon`
3.  [详细说明](https://blog.csdn.net/sugoods/article/details/108984326)

## 快捷键图标
|           |  键位           |
| --------- | -------------- |
| <kbd>⇧</kbd> | Shift       |
| <kbd>⌃</kbd> | Control   	 |
| <kbd>⌥</kbd> | Option 		 |
| <kbd>⌘</kbd> | Command   	 |

## 代码参考
https://github.com/greyby/hammerspoon

## 语言切换

- en [English](README_en.md)
- zh_CN [简体中文](README.md)

## 功能

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

* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>I</kbd> `IntelliJ IDEA`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>T</kbd> `Terminal`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Z</kbd> `Calculator`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>D</kbd> `Finder`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Q</kbd> `Activity Monitor`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>S</kbd> `System Preferences`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>C</kbd> `Google Chrome`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>A</kbd> `Launchpad`

### 片段和备忘录

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>X</kbd> 添加一个片段或者备忘
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>V</kbd> 列出片段或备忘录并使用

### JSON格式化

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>G</kbd> JSON格式化

### 自动同步时间

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>T</kbd> 自动同步时间

需要安装expect，并设置登录密码

### 翻译

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> 翻译

支持百度和有道翻译API。百度翻译可直接使用。有道翻译需要先申请有道翻译API并配置appKey和appSecret

### 屏幕取色功能

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>P</kbd> 颜色拾取器

菜单栏点击屏幕取色，出现取色界面后点击颜色拾取器，就可以获取当前屏幕鼠标所在位置的颜色值

### 咖啡因

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>C</kbd> 咖啡因

菜单栏点击 咖啡因打开系统永不休眠功能，再点击一次就能关闭

### 状态栏显示输入法状态

可显示大小写状态，输入法状态，中英文状态。目前仅测试过搜狗输入法