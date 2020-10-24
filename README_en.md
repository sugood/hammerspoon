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

## Features

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

* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>I</kbd> `IntelliJ IDEA`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>T</kbd> `Terminal`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Z</kbd> `Calculator`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>D</kbd> `Finder`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>Q</kbd> `Activity Monitor`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>S</kbd> `System Preferences`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>C</kbd> `Google Chrome`
* <kbd>⌃</kbd><kbd>⇧</kbd> + <kbd>A</kbd> `Launchpad`

### Snippet & Memorandum

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>X</kbd> Add a snippet or memos
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>V</kbd> List snippet or memos and use them

### JSON format

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>G</kbd> JSON format

### automatic synchronization time

* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>T</kbd> automatic synchronization time

### Translation
* <kbd>⌥</kbd><kbd>⌘</kbd> + <kbd>F</kbd> Translation

Support baidu and youdao translation API. Baidu Translation can be used directly. Youdao translation requires first applying youdao translation API and configuring appKey and appSecret

###  Screen color selection function

Click the screen color in the menu bar, click the color picker after the screen color picker interface appears, and the color value at the position of the mouse on the screen can be obtained

### caffeine

On the menu bar, click caffeine to turn on the system's never sleep feature, and then click again to turn it off

### The status bar shows the status of the input method

Can display case status, input method status, Chinese and English status. So far, only sogou input method has been tested