--[[
  player head up display
]]
backlog_post("/// INIT test_sprite2d.lua ///");

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");
  local path = application.GetActivePath()

  local btn_sprite = Sprite( "./content/ui/kenney_ui-pack/PNG/grey_button07.png")
  local fx = btn_sprite.GetParams()
  fx.SetPos(Vector(self.x,self.y)) --position x,y
  --fx.EnableDrawRect(Vector(0, 0, 16, 16)) --crop image
  fx.SetSize(Vector(48,48)) -- width, height
  btn_sprite.SetParams(fx) -- set sprite image
  path.AddSprite(btn_sprite)

  while true do
    update() --need to call for wicked engine to update snyc.

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveSprite(btn_sprite)
		end

  end
end)