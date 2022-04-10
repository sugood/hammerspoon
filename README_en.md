# Hammerspoon Configuration

## Usage

1. Install [Hammerspoon](http://www.hammerspoon.org/)
2. `git clone https://github.com/sugood/hammerspoon.git ~/.hammerspoon`
3. [Detailed description](https://blog.csdn.net/sugoods/article/details/108984326)

## Modifier keys
|           |  Key           |
| --------- | -------------- |
| <kbd>⇧</kbd> | Shift       |
| <kbd>⌃</kbd> | Control   	 |
| <kbd>⌥</kbd> | Option 		 |
| <kbd>⌘</kbd> | Command   	 |

## Reference code
https://github.com/greyby/hammerspoon

## Language

- en [English](README_en.md)
- zh_CN [简体中文](README.md)

# SOFTWARE ENVIRONMENT
systems：MacOS 10.14 +

# Script Function description

The following functions have been performed

1. The status bar displays the status of the input method
2. Time synchronization
3. Screen color selection function
4. JSON formatting tools
5. Translation function (baidu and Youdao API support)
6. Caffeine (Set system to never sleep)
7. memo
8. Status bar displays system information (CPU/ memory/hard disk/Network speed)
9. Window management
10. Shortcut keys to quickly launch other applications

# Features

### JSON Formatting

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>G</kbd> JSON Formatting

#### Interface and function description
1. interface

![paste image](http://imgs.sugood.xyz/1642388815070fcmlt9bk.png?imageslim)

2. Introduction
 - THE JSON formatting
 - JSON code highlights
 - Can search
 - JSON to XML
 - JSON to CSV
 - JSON to YAML

### Snippet & Memorandum

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>X</kbd> Add a snippet or memos
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>V</kbd> List snippet or memos and use them

### automatic synchronization time

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>T</kbd> automatic synchronization time

### Translation
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> Translation

Support baidu and youdao translation API. Baidu Translation can be used directly. Youdao translation requires first applying youdao translation API and configuring appKey and appSecret

###  Screen color selection function

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>P</kbd> Screen color selection function

Click the screen color in the menu bar, click the color picker after the screen color picker interface appears, and the color value at the position of the mouse on the screen can be obtained

### caffeine

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>S</kbd> caffeine

On the menu bar, click caffeine to turn on the system's never sleep feature, and then click again to turn it off

### The status bar shows the status of the input method

Can display case status, input method status, Chinese and English status. So far, only sogou input method has been tested

### Window Management

#### Split Screen Actions

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>←</kbd> Left half
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>→</kbd> Right half
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>↑</kbd> Top half
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>↓</kbd>	Bottom half

#### Quarter Screen Actions

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>←</kbd> Left top quarter
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>→</kbd> Right bottom quarter
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>↑</kbd> Right top quarter
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⇧</kbd> + <kbd>↓</kbd> Left bottom quarter

#### Multiple Monitor

##### Move Cursor

* <kbd>⌃</kbd><kbd>⌥</kbd> + <kbd>←</kbd> Move cursor to next monitor
* <kbd>⌃</kbd><kbd>⌥</kbd> + <kbd>→</kbd> Move cursor to previous monitor

##### Move Windows

* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>←</kbd> Move active window to previous monitor
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>→</kbd> Move active window to next monitor
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>1</kbd> Move active window to monitor 1 and maximize the window
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>2</kbd> Move active window to monitor 2 and maximize the window


#### Other

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> Full Screen
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>M</kbd> Maximize Window
* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>C</kbd> Window Center


* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>H</kbd>  Switch active window
* <kbd>⇧</kbd><kbd>⌥</kbd> + <kbd>/</kbd>  Display a keyboard hint for switching focus to each window

### System Tools

* <kbd>⌃</kbd><kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>L</kbd> Lock Screen

### Launch Application

* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>A</kbd> `Launchpad`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>C</kbd> `calendar`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>D</kbd> `Disk Utility`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>E</kbd> `Finder`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>G</kbd> `Google Chrome`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Q</kbd> `Activity Monitor`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>T</kbd> `Terminal`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>S</kbd> `System Preferences`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Z</kbd> `Calculator`