
backlog_post("Begin script: test_camera.lua");
local scene = GetScene()

runProcess(function()
  --backlog_post("hello world");
  local path = application.GetActivePath()
  --update()
  local camera_entity = CreateEntity()
  scene.Component_CreateName(camera_entity).SetName("camera")
  scene.Component_CreateTransform(camera_entity)
  scene.Component_CreateCamera(camera_entity)

  -- local camera = GetCamera()

  -- camera.TransformCamera(camera_transform)
	-- camera.UpdateCamera()
  update()



  backlog_post(os.time());
end)

backlog_post("Script complete.");