hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

-- Use the standardized config location, if present
custom_config = hs.fs.pathToAbsolute(os.getenv("HOME") .. '/.config/hammerspoon/private/config.lua')
if custom_config then
    print("Loading custom config")
    dofile( os.getenv("HOME") .. "/.config/hammerspoon/private/config.lua")
    privatepath = hs.fs.pathToAbsolute(hs.configdir .. '/private/config.lua')
    if privatepath then
        hs.alert("You have config in both .config/hammerspoon and .hammerspoon/private.\nThe .config/hammerspoon one will be used.")
    end
else
    -- otherwise fallback to 'classic' location.
    if not privatepath then
        privatepath = hs.fs.pathToAbsolute(hs.configdir .. '/private')
        -- Create `~/.hammerspoon/private` directory if not exists.
        hs.fs.mkdir(hs.configdir .. '/private')
    end
    privateconf = hs.fs.pathToAbsolute(hs.configdir .. '/private/config.lua')
    if privateconf then
        -- Load awesomeconfig file if exists
        require('private/config')
    end
end

function print_r ( t )  
  print("=======================")
  local print_r_cache={}
  local function sub_print_r(t,indent)
      if (print_r_cache[tostring(t)]) then
          print(indent.."*"..tostring(t))
      else
          print_r_cache[tostring(t)]=true
          if (type(t)=="table") then
              for pos,val in pairs(t) do
                  if (type(val)=="table") then
                      print(indent.."["..pos.."] => "..tostring(t).." {")
                      sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                      print(indent..string.rep(" ",string.len(pos)+6).."}")
                  elseif (type(val)=="string") then
                      print(indent.."["..pos..'] => "'..val..'"')
                  else
                      print(indent.."["..pos.."] => "..tostring(val))
                  end
              end
          else
              print(indent..tostring(t))
          end
      end
  end
  if (type(t)=="table") then
      print(tostring(t).." {")
      sub_print_r(t,"  ")
      print("}")
  else
      sub_print_r(t,"  ")
  end
  print()
  print("=======================")
end

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
hs.loadSpoon("ModalMgr")

-- Define default Spoons which will be loaded later
if not hspoon_list then
    hspoon_list = {
        -- "AClock",
        -- "BingDaily",
        -- "CircleClock",
        -- "ClipShow",
        -- "CountDown",
        -- "HSaria2",
        -- "HSearch",
        -- "SpeedMenu",
        -- "FnMate",
        "KSheet",
        -- "LookupSelection",
        -- "DeepLTranslate",
        -- "PopupTranslateSelection",
        "HCalendar",
        "WinWin",
    }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

function alertIM(txt)
    hs.alert.closeAll()
    local alertStyle = hs.alert.defaultStyle
    alertStyle.radius = 10
    hs.alert.defaultStyle.strokeColor.alpha = 0.25
    hs.alert.defaultStyle.fillColor.alpha = 0.5
    hs.alert.defaultStyle.strokeWidth = 1
    alertStyle.fadeInDuration = 0.6
    alertStyle.fadeOutDuration = 0.6
    hs.alert.show(txt, alertStyle, hs.screen.mainScreen(), 1)
end
local function Chinese()
    hs.keycodes.setMethod('Squirrel')
    alertIM(" 中")
    print("Switch to Chinese")
end
local function English()
    hs.keycodes.setLayout('ABC')
    alertIM(" En")
    print("Switch to English")
end
local function toggleInputMethod()
    if hs.keycodes.currentMethod() == nil then
        Chinese()
    else
        English()
    end
end

-- 使用 shift 自动切换系统输入法
-- 200000000ns === 200ms === 0.2s
timesplit = 200000000
shiftPressedTimestamp = hs.timer.absoluteTime()
hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(e)
    local keyCode = e:getKeyCode()
    -- 如果同时按了其他键作为组合键，则不切换输入法
    if keyCode ~= 56 then
        shiftPressedTimestamp = shiftPressedTimestamp - timesplit
        return
    end
    local nowTime = hs.timer.absoluteTime()
    -- 在 200ms 内默认为切换行为
    if keyCode == 56 and (nowTime - shiftPressedTimestamp <= timesplit) then
        toggleInputMethod()
    else
        shiftPressedTimestamp = nowTime
    end
end):start()


appInputMethod = {
    Hammerspoon             = English,
    iTerm2                  = English,
    Safari                  = English,
    ['Google Chrome']       = English,
    ['Code - Insiders']     = English,
    ['钉钉']                = Chinese,
    ['阿里邮箱']             = Chinese,
    Typora                  = Chinese,
    WeChat                  = Chinese
}

hs.application.watcher.new(function(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        for app, fn in pairs(appInputMethod) do
            if app == appName then fn() end
        end
        print("    =>", appName)
    end
end):start()

----------------------------------------------------------------------------------------------------
-- Then we create/register all kinds of modal keybindings environments.
----------------------------------------------------------------------------------------------------
-- Register windowHints (Register a keybinding which is NOT modal environment with modal supervisor)
-- 切换应用程序
spoon.ModalMgr.supervisor:bind("alt", "tab", 'Show Window Hints', function()
  spoon.ModalMgr:deactivateAll()
  hs.hints.windowHints()
end)

----------------------------------------------------------------------------------------------------
-- resizeM modal environment
if spoon.WinWin then
    spoon.ModalMgr:new("resizeM")
    local cmodal = spoon.ModalMgr.modal_list["resizeM"]
    cmodal:bind('', 'escape', '退出', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    cmodal:bind('', 'tab', '切换显示快捷键', function() spoon.ModalMgr:toggleCheatsheet() end)
    cmodal:bind('', 'A', '向左移动', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    cmodal:bind('', 'D', '向右移动', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    cmodal:bind('', 'W', '向上移动', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    cmodal:bind('', 'S', '向下移动', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
    cmodal:bind('shift', 'H', '移动至屏幕左侧', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
    cmodal:bind('shift', 'L', '移动至屏幕右侧', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
    cmodal:bind('shift', 'K', '移动至屏幕上方', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
    cmodal:bind('shift', 'J', '移动至屏幕下方', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)
    cmodal:bind('', 'F', '全屏', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
    cmodal:bind('', 'C', '居中', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)
    cmodal:bind('', '=', '放大', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    cmodal:bind('', '-', '缩小', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
    cmodal:bind('', 'H', '宽度减小', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    cmodal:bind('', 'L', '宽度增加', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    cmodal:bind('', 'K', '高度减小', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    cmodal:bind('', 'J', '高度增加', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
    cmodal:bind('', 'space', '移动到下一个屏幕', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("next") end)
    cmodal:bind('', '[', '撤销', function() spoon.WinWin:undo() end)
    cmodal:bind('', ']', '重做', function() spoon.WinWin:redo() end)
    -- cmodal:bind('', 'Q', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    -- cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNW") end)
    -- cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNE") end)
    -- cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSW") end)
    -- cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSE") end)
    -- cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("left") end)
    -- cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("right") end)
    -- cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("up") end)
    -- cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("down") end)
    -- cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)
    -- Register resizeM with modal supervisor
    hsresizeM_keys = hsresizeM_keys or {"alt", "R"}
    if string.len(hsresizeM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter resizeM Environment", function()
            -- Deactivate some modal environments or not before activating a new one
            spoon.ModalMgr:deactivateAll()
            -- Show an status indicator so we know we're in some modal environment now
            spoon.ModalMgr:activate({"resizeM"}, "#B22222")
        end)
    end
end

----------------------------------------------------------------------------------------------------
-- cheatsheetM modal environment (Because KSheet Spoon is NOT loaded, cheatsheetM will NOT be activated)
-- 查看应用快捷键
if spoon.KSheet then
  spoon.ModalMgr:new("cheatsheetM")
  local cmodal = spoon.ModalMgr.modal_list["cheatsheetM"]
  cmodal:bind('', 'escape', 'Deactivate cheatsheetM', function()
    spoon.KSheet:hide()
    spoon.ModalMgr:deactivate({"cheatsheetM"})
  end)
  cmodal:bind('', 'Q', 'Deactivate cheatsheetM', function()
    spoon.KSheet:hide()
    spoon.ModalMgr:deactivate({"cheatsheetM"})
  end)

  -- Register cheatsheetM with modal supervisor

  spoon.ModalMgr.supervisor:bind("alt", "s", "Enter cheatsheetM Environment", function()
    spoon.KSheet:show()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({"cheatsheetM"})
  end)
end

----------------------------------------------------------------------------------------------------
-- Finally we initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()
