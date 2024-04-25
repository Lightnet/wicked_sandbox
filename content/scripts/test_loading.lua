--display loading screen

backlog_post("/// INIT test_loading.lua ///");
runProcess(function()
  backlog_post("/// INIT runProcess FN ///");
  local ls = LoadingScreen()

  local font = SpriteFont()
  font.SetText("Loading...")
  font.SetSize(40)
  local ts = font.TextSize()
  --not center?
  font.SetPos(Vector(
    application.GetCanvas().GetLogicalWidth() * .5 - ts.X * .5,
    application.GetCanvas().GetLogicalHeight() * .5 - ts.Y * .5
  ))
  ls.AddFont(font)

  --ls:AddLoadingTask("preload.lua")
  --ls:OnFinished("Wicked/Content/scripts/character_controller/character_controller.lua")

  application.SetActivePath(ls)
end)



