backlog_post("/// SCRIPT game.lua ///");

--package.path = package.path .. ";!\\content\\scripts\\?.lua"
--package.path = "./content/scripts/?.lua;" .. package.path
-- backlog_post("package.path: ",package.path);
--dofile 'content/scripts/foo.lua'
-- local foo = require 'content/scripts/foo'
--local test = require 'test'
--backlog_post("///test: ",test);
--backlog_post("package.path: ",package.path);
--backlog_post("///test: ",test);
--backlog_post("///bar: ",bar);
-- backlog_post("/////////////////////////////////////");
-- backlog_post("///foo: ",foo);
-- backlog_post("///test: ",test);
-- backlog_post("/////////////////////////////////////");

local scene = GetScene()

runProcess(function()
  scene.Clear()
  ClearWorld()
  SetProfilerEnabled(false) -- have a bit more screen space
  update()
  LoadModel(script_dir() .. "content/level.wiscene")
  local prevPath = application.GetActivePath()
  local path = RenderPath3D()
  application.SetActivePath(path)

  local help_text = ""
  help_text = help_text .. "Wicked Engine sample script\n"
  help_text = help_text .. "Escape Key return to editor\n"

  local font = SpriteFont(help_text);
	font.SetSize(16)
	--font.SetPos(Vector(10, GetScreenHeight() - 10))
	font.SetPos(Vector(10, 100))

	font.SetAlign(WIFALIGN_LEFT, WIFALIGN_BOTTOM)
	font.SetColor(0xFFADA3FF)
	font.SetShadowColor(Vector(0,0,0,1))
	path.AddFont(font)

  local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name
  --cam_component = scene.Component_GetCamera(cam_entity)
  local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  GetCamera().TransformCamera(transform) -- Transform the main camera with transform that you got from camera in the scene

  -- backlog_post("/////////////////////////////////////");
  -- backlog_post("///",os.time());
  -- backlog_post("/////////////////////////////////////");
  --local camera = GetCamera()
  
  while true do
    local camera = GetCamera()
    camera.UpdateCamera()
    update()

    if(not backlog_isactive() and input.Press(KEYBOARD_BUTTON_ESCAPE)) then
      backlog_post("ESC ", os.time())
      --path.RemoveFont(font)
      application.SetActivePath(prevPath)
      killProcesses()
      return
    end
    --backlog_post("///",os.time());
    -- if(not backlog_isactive() and input.Press(string.byte('R'))) then
		-- 	-- reload script
		-- 	backlog_post("RELOAD")
		-- 	killProcesses()
		-- 	application.SetActivePath(prevPath)
		-- 	--dofile(script_dir() .. "fighting_game.lua")
    --   --dofile(script_dir() .. "game.lua")
		-- 	return
		-- end
  end
end)