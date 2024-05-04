local scene = GetScene()

runProcess(function()
  --get current render editor
  local prevPath = application.GetActivePath()--save render for editor
  --once setup
  scene.Clear()
  ClearWorld()
  SetProfilerEnabled(false) -- have a bit more screen space
  LoadModel(script_dir() .. "assets/level.wiscene")
  local path = RenderPath3D() --new 3d render
  application.SetActivePath(path) -- set render

  cam_entity = scene.Entity_FindByName("camera") -- query the object by name
  transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  GetCamera().TransformCamera(transform) -- Transform the main camera with transform that you got from camera in the scene

  --loop
  while true do
    update()
    --backlog_post("///",os.time());
    if not backlog_isactive() then
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())--log key
        application.SetActivePath(prevPath)--return to editor render
        killProcesses()
        return
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