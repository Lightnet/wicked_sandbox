backlog_post("/////////////////////////////////////");

--package.path = package.path .. ";!\\content\\scripts\\?.lua"
--package.path = "./content/scripts/?.lua;" .. package.path
backlog_post("package.path: ",package.path);
--dofile 'content/scripts/foo.lua'
local foo = require 'content/scripts/foo'
--local test = require 'test'
--backlog_post("///test: ",test);
--backlog_post("package.path: ",package.path);
--backlog_post("///test: ",test);
--backlog_post("///bar: ",bar);
backlog_post("/////////////////////////////////////");
backlog_post("///foo: ",foo);
backlog_post("///test: ",test);
backlog_post("/////////////////////////////////////");

local scene = GetScene()

runProcess(function()
  scene.Clear()
  ClearWorld()
  SetProfilerEnabled(false) -- have a bit more screen space
  LoadModel(script_dir() .. "content/level.wiscene")
  local path = RenderPath3D()
  application.SetActivePath(path)

  SetProfilerEnabled(false) -- have a bit more screen space

  local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name
  --cam_component = scene.Component_GetCamera(cam_entity)
  local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  GetCamera().TransformCamera(transform) -- Transform the main camera with transform that you got from camera in the scene

  backlog_post("/////////////////////////////////////");
  backlog_post("///",os.time());
  backlog_post("/////////////////////////////////////");

  local camera = GetCamera()
  
  while true do
    local camera = GetCamera()
    camera.UpdateCamera()
    update()
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