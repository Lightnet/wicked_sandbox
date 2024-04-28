



local scene = GetScene()


backlog_post("Begin script: blank.lua");
runProcess(function()
  update()


  local prevPath = application.GetActivePath()
  local path = RenderPath3D()
  application.SetActivePath(path)

  --local loadingscreen = LoadingScreen()
  LoadModel(script_dir() .. "content/level.wiscene")

  -- local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name
  -- local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  -- GetCamera().TransformCamera(transform)
  
  while true do


    if not backlog_isactive() then
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
        application.SetActivePath(prevPath)
      end
    end

    update()
  end
end)

backlog_post("Script complete.");