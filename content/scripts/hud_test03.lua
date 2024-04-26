--[[
  player head up display

  mouse over test
]]
backlog_post("/// INIT hud.lua ///");

local path = application.GetActivePath()
local hover_color = Vector(0.6,0.6,0.6,1)
local out_color = Vector(0.3,0.3,0.3,1)
local press_color = Vector(0.8,0.8,0.8,1)

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");
  local sprite_panel = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  local fx = sprite_panel.GetParams()
  fx.SetPos(Vector(64,64)) --position x,y
  --fx.EnableDrawRect(Vector(0, 0, 16, 16)) --crop image
  fx.SetSize(Vector(32,32)) -- width, height
  fx.SetColor(hover_color) --color r,g,b,alpha ???
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
    update()
    local mouse = input.GetPointer()
    local pos_x = 64
    local pos_y = 64
    local size = 32

    local hit = mouse.X > pos_x and mouse.X < pos_x + size and
       mouse.Y > pos_x and mouse.Y < pos_x + size
    
    if hit then 
      --backlog_post("OVER ?")
      local fx = sprite_panel.GetParams()
      

      if input.Down( MOUSE_BUTTON_LEFT ) then
        backlog_post("MOUSE_BUTTON_LEFT")
        fx.SetColor(press_color)
      else
        fx.SetColor(hover_color)
      end
      sprite_panel.SetParams(fx)
      
    else
      --backlog_post("OUT ?")
      local fx = sprite_panel.GetParams()
      fx.SetColor(out_color)
      sprite_panel.SetParams(fx)
    end

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveFont(font)
      path.RemoveSprite(sprite_panel)
		end
  end
end)