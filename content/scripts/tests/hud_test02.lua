--[[
  player head up display

  mouse over test
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

  --sprite_button = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
  local sprite_panel = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  --local params = ImageParams(0,0,64,64)
  --sprite_button.SetParams(params)
  local fx = sprite_panel.GetParams()
  fx.SetPos(Vector(64,64)) --position x,y
  --fx.EnableDrawRect(Vector(0, 0, 16, 16)) --crop image
  fx.SetSize(Vector(32,32)) -- width, height
  fx.SetColor(Vector(0,1,0.5,1)) --color r,g,b,alpha ???
  sprite_panel.SetParams(fx) -- set sprite image
  path.AddSprite(sprite_panel)


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

    local mouse = input.GetPointer()

    --backlog_post("/// POS: ", mouse.X, ": ", mouse.Y);--pass
    --backlog_post("/// POS: ", mouse.x, ": ", mouse.y);--nope
    local pos_x = 64
    local pos_y = 64
    local size = 32

    local hit = mouse.X > pos_x and mouse.X < pos_x + size and
       mouse.Y > pos_x and mouse.Y < pos_x + size
    
    if hit then 
      --backlog_post("OVER ?")
      if input.Press( MOUSE_BUTTON_LEFT ) then
        backlog_post("MOUSE_BUTTON_LEFT")
      end
    else
      --backlog_post("OUT ?")
    end

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveFont(font)
      path.RemoveSprite(sprite_panel)
		end
  end
end)