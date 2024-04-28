backlog_post("/// SCRIPT START mainmenu.lua ///");

package.path = package.path .. ";!\\content\\scripts\\?.lua"
local ui = require 'content/scripts/ui'
local scene = GetScene()

gameData = "Hello World mainmenu!"--testing...

runProcess(function()
  
  --get current render editor
  local prevPath = application.GetActivePath()
  scene.Clear()
  ClearWorld()
  --create new render
  local path = RenderPath3D()
  -- set new render
  application.SetActivePath(path)
  --setup buttons
  local btn_play = ui.button:new()
  btn_play:setup(path,0,0,128,32)
  btn_play:func(function()
    dofile(script_dir() .. "game.lua")
  end)

  local btn_settings = ui.button:new()
  btn_settings:setup(path,0,0+32,128,32)

  local btn_quit = ui.button:new()
  btn_quit:setup(path,0,0+32*2,128,32)

  btn_quit:func(function()
    application.Exit()
  end)


  while true do
    update()
    --input update for rect min and max
    btn_play:update()
    btn_settings:update()
    btn_quit:update()

    if(not backlog_isactive() and input.Press(KEYBOARD_BUTTON_ESCAPE)) then
      backlog_post("ESC ", os.time())
      --path.RemoveFont(font)
      application.SetActivePath(prevPath)
      killProcesses()
      return
    end

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      --path.RemoveFont(font)
      --path.RemoveSprite(sprite_panel)
		end
  end
  --end runProcess
end)

backlog_post("/// SCRIPT END mainmenu.lua ///");
