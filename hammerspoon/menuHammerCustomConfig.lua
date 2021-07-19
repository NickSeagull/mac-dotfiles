menuHammerMenuList = {
  mainMenu = {
      parentMenu = nil,
      menuHotkey = {{'alt'}, 'space'},
      menuItems =  {
          {cons.cat.submenu, '', 'A', 'Applications', {
                {cons.act.menu, "menu_application"}
          }},
          {cons.cat.submenu, '', 'M', 'Meta', {
                {cons.act.menu, "menu_meta"}
          }},
          {cons.cat.submenu, '', 'W', 'Window Management', {
                {cons.act.menu, "menu_window"}
          }},
          {cons.cat.action, '', 'T', "Terminal", {
                {cons.act.launcher, 'Terminal'}
          }},
          {cons.cat.action, '', 'D', 'Desktop', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'd'},
          }},
          {cons.cat.action, '', 'E', "Split Safari/iTunes", {
              {cons.act.func, function()
                    -- See Hammerspoon layout documentation for more info on this
                    local mainScreen = hs.screen{x=0,y=0}
                    hs.layout.apply({
                            {"Safari", nil, mainScreen, hs.layout.left50, nil, nil},
                            {"iTunes", nil, mainScreen, hs.layout.right50, nil, nil},
                    })
              end }
          }},
          {cons.cat.action, '', 'H', "Hammerspoon Manual", {
                {cons.act.func, function()
                    hs.doc.hsdocs.forceExternalBrowser(true)
                    hs.doc.hsdocs.moduleEntitiesInSidebar(true)
                    hs.doc.hsdocs.help()
                end }
          }},
          {cons.cat.action, '', 'X', "Mute/Unmute", {
                {cons.act.mediakey, "mute"}
          }},
      }
  },

  menu_application = {
      parentMenu = "mainMenu",
      menuHotkey = nil,
      menuItems = {
          {cons.cat.action, '', 'S', "Slack", {
                {cons.act.launcher, 'Slack'}
          }},
          {cons.cat.action, '', 'P', "Spotify", {
                {cons.act.launcher, 'Spotify'}
          }},
      }
  },

  menu_meta = {
    parentMenu = "mainMenu",
    menuHotkey = nil,
    menuItems = {
      {cons.cat.action, '', 'R', 'Reload config', {
          {cons.act.func, function()
            hs.alert("Config reloaded")
            hs.timer.doAfter(1, function()
              hs.reload()
            end)
          end}
      }}
    }
  },

  menu_window = {
    parentMenu = "mainMenu",
    menuHotkey = nil,
    menuItems = {
      {cons.cat.action, '', 'M', 'Maximize window', {
          {cons.act.func, function()
            hs.window.focusedWindow():maximize()
          end}
        }
      }
    }
  }
}