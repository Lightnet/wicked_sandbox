--[[
  player head up display
]]
backlog_post("/// INIT hud.lua ///");

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");
  --local ls = LoadingScreen()
  -- local prevPath = application.GetActivePath()
	--local path = RenderPath3D()
  --application.SetActivePath(path)
  -- local path = prevPath
  local path = application.GetActivePath()

  sprite_button = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
  --local params = ImageParams(0,0,64,64)
  --sprite_button.SetParams(params)
  local fx = sprite_button.GetParams()
  fx.SetPos(Vector(0,0))
  --fx.SetSize(Vector(64,64))
  backlog_post("fx.GetSize: ", fx.GetSize());
  
  sprite_button.SetParams(fx)
  --sprite_button.SetParams(fx)
  path.AddSprite(sprite_button)
  

  local help_text = ""
  help_text = help_text .. "Wicked Engine sample script\n"

  local font = SpriteFont(help_text);
	font.SetSize(16)
	--font.SetPos(Vector(10, GetScreenHeight() - 10))
	font.SetPos(Vector(10, 100))

	font.SetAlign(WIFALIGN_LEFT, WIFALIGN_BOTTOM)
	font.SetColor(0xFFADA3FF)
	font.SetShadowColor(Vector(0,0,0,1))
	path.AddFont(font)

  while true do
    -- local camera = GetCamera()
    -- camera.UpdateCamera()
    update()
    --backlog_post("///",os.time());
    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveFont(font)
      path.RemoveSprite(sprite_button)
		end
  end
end)