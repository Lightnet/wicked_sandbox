--[[
  setup game logic here.
]]
backlog_post("/// SCRIPT game.lua ///");
SetProfilerEnabled(false) -- have a bit more screen space
-- package.path = package.path .. ";!\\content\\scripts\\?.lua"
-- package.path = "./content/scripts/?.lua;" .. package.path
-- backlog_post("package.path: ",package.path);
-- dofile 'content/scripts/foo.lua'
-- local foo = require 'content/scripts/foo'
-- local test = require 'test'
-- backlog_post("///test: ",test);
-- backlog_post("///bar: ",bar);
-- backlog_post("///foo: ",foo);
-- backlog_post("/////////////////////////////////////");

backlog_post("/// global gameData:", gameData)

local scene = GetScene()

function InfoText(path)
  local help_text = ""
  help_text = help_text .. "Wicked Engine game script\n"
  help_text = help_text .. "Escape Key return to editor\n"

  local font = SpriteFont(help_text);
	font.SetSize(16)
	--font.SetPos(Vector(10, GetScreenHeight() - 10))
	font.SetPos(Vector(10, 100))

	font.SetAlign(WIFALIGN_LEFT, WIFALIGN_BOTTOM)
	font.SetColor(0xFFADA3FF)
	font.SetShadowColor(Vector(0,0,0,1))
	path.AddFont(font)
end

--display font text
function ph_spawn_cube_camera(_scene)
  LoadModel(script_dir() .. "./content/scenes/level.wiscene")
  --LoadModel("./content/scenes/level.wiscene")
  local cam_entity = _scene.Entity_FindByName("camera") -- query the camera object by name
  --cam_component = scene.Component_GetCamera(cam_entity)
  local transform = _scene.Component_GetTransform(cam_entity) -- get camera's transform
  GetCamera().TransformCamera(transform) -- Transform the main camera with transform that you got from camera in the scene
end

runProcess(function()
  scene.Clear()
  ClearWorld()
  --get current render editor
  local prevPath = application.GetActivePath()
  --create new render
  local path = RenderPath3D()
  -- set new render
  application.SetActivePath(path)

  ph_spawn_cube_camera(scene)

  InfoText(path)

  update()
  --local camera = GetCamera()
  
  while true do
    --local camera = GetCamera()
    --camera.UpdateCamera()
    update()

    if(not backlog_isactive() and input.Press(KEYBOARD_BUTTON_ESCAPE)) then
      backlog_post("ESC ", os.time())
      --path.RemoveFont(font)
      application.SetActivePath(prevPath)
      killProcesses()
      return
    end

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
			-- reload script
			backlog_post("RELOAD")
			killProcesses()
			dofile(script_dir() .. "game.lua")
			return
		end
  end
end)