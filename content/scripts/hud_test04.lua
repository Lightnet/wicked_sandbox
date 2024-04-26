--[[
  player head up display
  create button class
]]
backlog_post("/// INIT hud.lua ///");
-- https://www.lua.org/pil/16.1.html
local button = {
  hover_color = Vector(0.6,0.6,0.6,1),
  out_color = Vector(0.3,0.3,0.3,1),
  press_color = Vector(0.8,0.8,0.8,1),
  btn_sprite = nil,
  x = 0,
  y = 0,
  width = 32,
  height = 32
}

function button:new(o)
  o = o or {
    hover_color = Vector(0.6,0.6,0.6,1),
    out_color = Vector(0.3,0.3,0.3,1),
    press_color = Vector(0.8,0.8,0.8,1),
    btn_sprite = nil,
    x = 0,
    y = 0,
    width = 32,
    height = 32
  }   -- create object if user does not provide 
  setmetatable(o, self)
  self.__index = self
  return o
end

function button:setup(path,x,y,width,height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.btn_sprite = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  local fx = self.btn_sprite.GetParams()
  fx.SetPos(Vector(self.x,self.y)) --position x,y
  --fx.EnableDrawRect(Vector(0, 0, 16, 16)) --crop image
  fx.SetSize(Vector(self.width,self.height)) -- width, height
  fx.SetColor(self.hover_color) --color r,g,b,alpha ???
  self.btn_sprite.SetParams(fx) -- set sprite image
  path.AddSprite(self.btn_sprite)
  return self
end

function button:update()

  local mouse = input.GetPointer()
  local hit = mouse.X > self.x and mouse.X < self.x + self.width and
              mouse.Y > self.y and mouse.Y < self.y + self.height

  if hit then 
    --backlog_post("OVER ?")
    local fx = self.btn_sprite.GetParams()

    if input.Down( MOUSE_BUTTON_LEFT ) then
      backlog_post("MOUSE_BUTTON_LEFT")
      fx.SetColor(self.press_color)
    else
      fx.SetColor(self.hover_color)
    end
    self.btn_sprite.SetParams(fx)
    
  else
    --backlog_post("OUT ?")
    local fx = self.btn_sprite.GetParams()
    fx.SetColor(self.out_color)
    self.btn_sprite.SetParams(fx)
  end
end


local path = application.GetActivePath()

local btn_test = button:new()
btn_test:setup(path,0,0,32,32)

local btn_test2 = button:new()
btn_test2:setup(path,0,64,32,32)

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");

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
    btn_test:update()
    btn_test2:update()

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveFont(font)
      path.RemoveSprite(sprite_panel)
		end
  end
end)