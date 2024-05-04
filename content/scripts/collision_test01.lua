--[[
  setup game logic here.
]]
backlog_post("/// SCRIPT game.lua ///");
SetProfilerEnabled(false) -- have a bit more screen space

local scene = GetScene()

--display font text
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


function ph_spawn_cube_camera(_scene)
  LoadModel(script_dir() .. "../../content/scenes/level2.wiscene")
  --LoadModel("./content/scenes/level.wiscene")

  local cam_entity = _scene.Entity_FindByName("camera") -- query the camera object by name
  --cam_component = scene.Component_GetCamera(cam_entity)
  local transform = _scene.Component_GetTransform(cam_entity) -- get camera's transform
  GetCamera().TransformCamera(transform) -- Transform the main camera with transform that you got from camera in the scene


  --local player_entity = _scene.Entity_FindByName("player") -- query the player object by name
  --local player_transform = _scene.Component_GetTransform(player_entity) -- get camera's transform

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

  local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name

  local player_entity = scene.Entity_FindByName("player") -- query the player object by name
  local player_transform = scene.Component_GetTransform(player_entity) -- get camera's transform

  InfoText(path)

  update()
  --local camera = GetCamera()
  
  while true do
    --local camera = GetCamera()
    --camera.UpdateCamera()
    update()


    if not backlog_isactive() then
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
        --path.RemoveFont(font)
        application.SetActivePath(prevPath)
        killProcesses()
        return
      end

      local lookDir = Vector()--line 566 character_controller.lua
      local speed = 0.5
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
      end
      if input.Down(string.byte('A')) then
        backlog_post("A")
        lookDir = lookDir:Add( Vector(-speed) )
      end
      if input.Down(string.byte('D')) then
        backlog_post("D")
        lookDir = lookDir:Add( Vector(speed) )
      end
      if input.Down(string.byte('S')) then
        backlog_post("S")
        lookDir = lookDir:Add( Vector(0,0,-speed) )
      end
      if input.Down(string.byte('W')) then
        backlog_post("W")
        lookDir = lookDir:Add( Vector(0,0,speed) )
      end
      if(lookDir.Length() > 0) then

        
        local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
        GetCamera().TransformCamera(transform)
        
        player_transform.Translate(lookDir)
      end

      if input.Press(string.byte('R')) then
        -- reload script
        backlog_post("RELOAD")
        killProcesses()
        --dofile(script_dir() .. "game.lua")
        return
      end
    end

  end
end)