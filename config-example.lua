-- Specify Spoons which will be loaded
hspoon_list = {
    "AClock",
    "BingDaily",
    -- "Calendar",
    "CircleClock",
    "ClipShow",
    "CountDown",
    "FnMate",
    "HCalendar",
    "HSaria2",
    "HSearch",
    -- "KSheet",
    "SpeedMenu",
    -- "TimeFlow",
    -- "UnsplashZ",
    "WinWin",
}

-- appM environment keybindings. Bundle `id` is prefered, but application `name` will be ok.
hsapp_list = {
    {key = 'a', name = 'Atom'},
    {key = 'c', id = 'com.google.Chrome'},
    {key = 'd', name = 'ShadowsocksX'},
    {key = 'e', name = 'Emacs'},
    {key = 'f', name = 'Finder'},
    {key = 'i', name = 'iTerm'},
    {key = 'k', name = 'KeyCastr'},
    {key = 'l', name = 'Sublime Text'},
    {key = 'm', name = 'MacVim'},
    {key = 'o', name = 'LibreOffice'},
    {key = 'p', name = 'mpv'},
    {key = 'r', name = 'VimR'},
    {key = 's', name = 'Safari'},
    {key = 't', name = 'Terminal'},
    {key = 'v', id = 'com.apple.ActivityMonitor'},
    {key = 'w', name = 'Mweb'},
    {key = 'y', id = 'com.apple.systempreferences'},
}

-- Modal supervisor keybinding, which can be used to temporarily disable ALL modal environments.
hsupervisor_keys = {{"cmd", "shift", "ctrl"}, "Q"}

-- Reload Hammerspoon configuration
hsreload_keys = {{"cmd", "shift", "ctrl"}, "R"}

-- Toggle help panel of this configuration.
hshelp_keys = {{"alt", "shift"}, "/"}

-- aria2 RPC host address
hsaria2_host = "http://localhost:6800/jsonrpc"
-- aria2 RPC host secret
hsaria2_secret = "token"

----------------------------------------------------------------------------------------------------
-- Those keybindings below could be disabled by setting to {"", ""} or {{}, ""}

-- Window hints keybinding: Focuse to any window you want
hswhints_keys = {"alt", "tab"}

-- appM environment keybinding: Application Launcher
hsappM_keys = {"alt", "A"}

-- clipshowM environment keybinding: System clipboard reader
hsclipsM_keys = {"alt", "C"}

-- Toggle the display of aria2 frontend
hsaria2_keys = {"alt", "D"}

-- Launch Hammerspoon Search
hsearch_keys = {"alt", "G"}

-- Read Hammerspoon and Spoons API manual in default browser
hsman_keys = {"alt", "H"}

-- countdownM environment keybinding: Visual countdown
hscountdM_keys = {"alt", "I"}

-- Lock computer's screen
hslock_keys = {"alt", "L"}

-- resizeM environment keybinding: Windows manipulation
hsresizeM_keys = {"alt", "R"}

-- cheatsheetM environment keybinding: Cheatsheet copycat
hscheats_keys = {"alt", "S"}

-- Show digital clock above all windows
hsaclock_keys = {"alt", "T"}

-- Type the URL and title of the frontmost web page open in Google Chrome or Safari.
hstype_keys = {"alt", "V"}

-- Toggle Hammerspoon console
hsconsole_keys = {"alt", "Z"}



----------------------------------------------------------------------------------------------------
-- appM modal environment
-- 快捷到达 APP
-- spoon.ModalMgr:new("appM")
-- local cmodal = spoon.ModalMgr.modal_list["appM"]
-- cmodal:bind('', 'escape', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
-- cmodal:bind('', 'Q', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
-- cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
-- if not hsapp_list then
--     hsapp_list = {
--         {key = 'f', name = 'Finder'},
--         {key = 's', name = 'Safari'},
--         {key = 't', name = 'Terminal'},
--         {key = 'v', id = 'com.apple.ActivityMonitor'},
--         {key = 'y', id = 'com.apple.systempreferences'},
--     }
-- end
-- for _, v in ipairs(hsapp_list) do
--     if v.id then
--         local located_name = hs.application.nameForBundleID(v.id)
--         if located_name then
--             cmodal:bind('', v.key, located_name, function()
--                 hs.application.launchOrFocusByBundleID(v.id)
--                 spoon.ModalMgr:deactivate({"appM"})
--             end)
--         end
--     elseif v.name then
--         cmodal:bind('', v.key, v.name, function()
--             hs.application.launchOrFocus(v.name)
--             spoon.ModalMgr:deactivate({"appM"})
--         end)
--     end
-- end
-- -- Then we register some keybindings with modal supervisor
-- hsappM_keys = hsappM_keys or {"alt", "A"}
-- if string.len(hsappM_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hsappM_keys[1], hsappM_keys[2], "Enter AppM Environment", function()
--         spoon.ModalMgr:deactivateAll()
--         -- Show the keybindings cheatsheet once appM is activated
--         spoon.ModalMgr:activate({"appM"}, "#FFBD2E", true)
--     end)
-- end


----------------------------------------------------------------------------------------------------
-- clipshowM modal environment
-- if spoon.ClipShow then
--     spoon.ModalMgr:new("clipshowM")
--     local cmodal = spoon.ModalMgr.modal_list["clipshowM"]
--     cmodal:bind('', 'escape', 'Deactivate clipshowM', function()
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'Q', 'Deactivate clipshowM', function()
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'N', 'Save this Session', function()
--         spoon.ClipShow:saveToSession()
--     end)
--     cmodal:bind('', 'R', 'Restore last Session', function()
--         spoon.ClipShow:restoreLastSession()
--     end)
--     cmodal:bind('', 'B', 'Open in Browser', function()
--         spoon.ClipShow:openInBrowserWithRef()
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'S', 'Search with Bing', function()
--         spoon.ClipShow:openInBrowserWithRef("https://www.bing.com/search?q=")
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'M', 'Open in MacVim', function()
--         spoon.ClipShow:openWithCommand("/usr/local/bin/mvim")
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'F', 'Save to Desktop', function()
--         spoon.ClipShow:saveToFile()
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'H', 'Search in Github', function()
--         spoon.ClipShow:openInBrowserWithRef("https://github.com/search?q=")
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'G', 'Search with Google', function()
--         spoon.ClipShow:openInBrowserWithRef("https://www.google.com/search?q=")
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)
--     cmodal:bind('', 'L', 'Open in Sublime Text', function()
--         spoon.ClipShow:openWithCommand("/usr/local/bin/subl")
--         spoon.ClipShow:toggleShow()
--         spoon.ModalMgr:deactivate({"clipshowM"})
--     end)

--     -- Register clipshowM with modal supervisor
--     hsclipsM_keys = hsclipsM_keys or {"alt", "C"}
--     if string.len(hsclipsM_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hsclipsM_keys[1], hsclipsM_keys[2], "Enter clipshowM Environment", function()
--             -- We need to take action upon hsclipsM_keys is pressed, since pressing another key to showing ClipShow panel is redundant.
--             spoon.ClipShow:toggleShow()
--             -- Need a little trick here. Since the content type of system clipboard may be "URL", in which case we don't need to activate clipshowM.
--             if spoon.ClipShow.canvas:isShowing() then
--                 spoon.ModalMgr:deactivateAll()
--                 spoon.ModalMgr:activate({"clipshowM"})
--             end
--         end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register HSaria2
-- if spoon.HSaria2 then
--     -- First we need to connect to aria2 rpc host
--     hsaria2_host = hsaria2_host or "http://localhost:6800/jsonrpc"
--     hsaria2_secret = hsaria2_secret or "token"
--     spoon.HSaria2:connectToHost(hsaria2_host, hsaria2_secret)

--     hsaria2_keys = hsaria2_keys or {"alt", "D"}
--     if string.len(hsaria2_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hsaria2_keys[1], hsaria2_keys[2], 'Toggle aria2 Panel', function() spoon.HSaria2:togglePanel() end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register Hammerspoon Search
-- if spoon.HSearch then
--     hsearch_keys = hsearch_keys or {"alt", "G"}
--     if string.len(hsearch_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hsearch_keys[1], hsearch_keys[2], 'Launch Hammerspoon Search', function() spoon.HSearch:toggleShow() end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register Hammerspoon API manual: Open Hammerspoon manual in default browser
-- hsman_keys = hsman_keys or {"alt", "H"}
-- if string.len(hsman_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hsman_keys[1], hsman_keys[2], "Read Hammerspoon Manual", function()
--         hs.doc.hsdocs.forceExternalBrowser(true)
--         hs.doc.hsdocs.moduleEntitiesInSidebar(true)
--         hs.doc.hsdocs.help()
--     end)
-- end

----------------------------------------------------------------------------------------------------
-- countdownM modal environment
-- if spoon.CountDown then
--     spoon.ModalMgr:new("countdownM")
--     local cmodal = spoon.ModalMgr.modal_list["countdownM"]
--     cmodal:bind('', 'escape', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
--     cmodal:bind('', 'Q', 'Deactivate countdownM', function() spoon.ModalMgr:deactivate({"countdownM"}) end)
--     cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
--     cmodal:bind('', '-', '1 Minutes Countdown', function()
--         spoon.CountDown:startFor(1)
--         spoon.ModalMgr:deactivate({"countdownM"})
--     end)
--     cmodal:bind('', '0', '5 Minutes Countdown', function()
--         spoon.CountDown:startFor(5)
--         spoon.ModalMgr:deactivate({"countdownM"})
--     end)
--     for i = 1, 9 do
--         cmodal:bind('', tostring(i), string.format("%s Minutes Countdown", 10 * i), function()
--             spoon.CountDown:startFor(10 * i)
--             spoon.ModalMgr:deactivate({"countdownM"})
--         end)
--     end
--     cmodal:bind('', 'return', '25 Minutes Countdown', function()
--         spoon.CountDown:startFor(25)
--         spoon.ModalMgr:deactivate({"countdownM"})
--     end)
--     cmodal:bind('', 'space', 'Pause/Resume CountDown', function()
--         spoon.CountDown:pauseOrResume()
--         spoon.ModalMgr:deactivate({"countdownM"})
--     end)

--     -- Register countdownM with modal supervisor
--     hscountdM_keys = hscountdM_keys or {"alt", "I"}
--     if string.len(hscountdM_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hscountdM_keys[1], hscountdM_keys[2], "Enter countdownM Environment", function()
--             spoon.ModalMgr:deactivateAll()
--             -- Show the keybindings cheatsheet once countdownM is activated
--             spoon.ModalMgr:activate({"countdownM"}, "#FF6347", true)
--         end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register lock screen
-- hslock_keys = hslock_keys or {"alt", "L"}
-- if string.len(hslock_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hslock_keys[1], hslock_keys[2], "Lock Screen", function()
--         hs.caffeinate.lockScreen()
--     end)
-- end


----------------------------------------------------------------------------------------------------
-- Register AClock
-- if spoon.AClock then
--     hsaclock_keys = hsaclock_keys or {"alt", "T"}
--     if string.len(hsaclock_keys[2]) > 0 then
--         spoon.ModalMgr.supervisor:bind(hsaclock_keys[1], hsaclock_keys[2], "Toggle Floating Clock", function() spoon.AClock:toggleShow() end)
--     end
-- end

----------------------------------------------------------------------------------------------------
-- Register browser tab typist: Type URL of current tab of running browser in markdown format. i.e. [title](link)
-- hstype_keys = hstype_keys or {"alt", "V"}
-- if string.len(hstype_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hstype_keys[1], hstype_keys[2], "Type Browser Link", function()
--         local safari_running = hs.application.applicationsForBundleID("com.apple.Safari")
--         local chrome_running = hs.application.applicationsForBundleID("com.google.Chrome")
--         if #safari_running > 0 then
--             local stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
--             if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
--         elseif #chrome_running > 0 then
--             local stat, data = hs.applescript('tell application "Google Chrome" to get {URL, title} of active tab of window 1')
--             if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
--         end
--     end)
-- end

----------------------------------------------------------------------------------------------------
-- Register Hammerspoon console
-- hsconsole_keys = hsconsole_keys or {"alt", "Z"}
-- if string.len(hsconsole_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hsconsole_keys[1], hsconsole_keys[2], "Toggle Hammerspoon Console", function() hs.toggleConsole() end)
-- end
