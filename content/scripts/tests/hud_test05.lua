--[[
  player head up display
  create button class
]]
backlog_post("/// INIT hud.lua ///");
-- https://github.com/turanszkij/WickedEngine/blob/master/Content/Documentation/ScriptingAPI-Documentation.md
-- https://www.lua.org/pil/16.1.html
local button = {
  hover_color = Vector(0.6,0.6,0.6,1),
  out_color = Vector(0.3,0.3,0.3,1),
  press_color = Vector(0.8,0.8,0.8,1),
  btn_sprite = nil,
  x = 0,
  y = 0,
  width = 32,
  height = 32,
  fn = nil
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
  self.path = path
  self.btn_sprite = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  local fx = self.btn_sprite.GetParams()
  fx.SetPos(Vector(self.x,self.y)) --position x,y
  --fx.EnableDrawRect(Vector(0, 0, 16, 16)) --crop image
  fx.SetSize(Vector(self.width,self.height)) -- width, height
  fx.SetColor(self.hover_color) --color r,g,b,alpha ???
  self.btn_sprite.SetParams(fx) -- set sprite image
  self.path.AddSprite(self.btn_sprite)
  return self
end

function button:update()

  local mouse = input.GetPointer()
  local hit = mouse.X > self.x and mouse.X < self.x + self.width and
              mouse.Y > self.y and mouse.Y < self.y + self.height

  if hit then 
    --backlog_post("OVER ?")
    local fx = self.btn_sprite.GetParams()

    if input.Press( MOUSE_BUTTON_LEFT ) then--check press to prevent loop call
      if self.fn then
        self.fn()
      end
    end

    if input.Down( MOUSE_BUTTON_LEFT ) then --check if mouse is down while loop
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

function button:func(_fn)
  self.fn = _fn
end

function button:SetHidden(_bool)
  self.btn_sprite.SetHidden(_bool)
end

function button:show()
  self.btn_sprite.SetHidden(false)
end

function button:hide()
  self.btn_sprite.SetHidden(true)
end

function button:destroy()
  self.path.RemoveSprite(self.btn_sprite)
end

--///////////////////////////////////////////////

local panel = {
  hover_color = Vector(0.6,0.6,0.6,1),
  out_color = Vector(0.3,0.3,0.3,1),
  press_color = Vector(0.8,0.8,0.8,1),
  --panel_sprite = nil,
  panel_top_left = nil, --image corner
  panel_top_middle = nil, --image middle
  panel_top_right = nil, --image corner
  panel_bottom_right = nil, --image corner
  panel_bottom_left = nil, --image corner
  panel_bottom_middle = nil, --image middle
  panel_right = nil, --image right
  panel_left = nil, --image left
  panel_center = nil, --image center
  x = 0,
  y = 0,
  width = 48,
  height = 48,
  min_width = 48,
  min_height = 48,
  fn = nil
}

function panel:new(o)
  o = o or {
    hover_color = Vector(0.6,0.6,0.6,1),
    out_color = Vector(0.3,0.3,0.3,1),
    press_color = Vector(0.8,0.8,0.8,1),
    --panel_sprite = nil, --image
    panel_top_left = nil, --image corner
    panel_top_middle = nil, --image middle
    panel_top_right = nil, --image corner
    panel_bottom_right = nil, --image corner
    panel_bottom_left = nil, --image corner
    panel_bottom_middle = nil, --image middle
    panel_right = nil, --image right
    panel_left = nil, --image left
    panel_center = nil, --image center
    x = 0,
    y = 0,
    width = 48,
    height = 48,
    min_width = 48,
    min_height = 48,
    fn = nil
  }   -- create object if user does not provide 
  setmetatable(o, self)
  self.__index = self
  return o
end

function panel:setup(path,x,y,width,height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.path = path
  self.panel_sprite = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  
  local fx = nil
  local fx1 = nil
  fx = self.panel_sprite.GetParams()
  --fx1 = self.panel_sprite.GetParams()
  -- fx.SetPos(Vector(0,64))
  -- fx.SetSize(Vector(48,48))
  -- self.panel_sprite.SetParams(fx)
  -- self.path.AddSprite(self.panel_sprite)

  -- local panel_top_left = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx.EnableDrawRect(Vector(0, 0, 12, 12)) --crop image
  -- fx.SetPos(Vector(0,0))
  -- fx.SetSize(Vector(12,12))
  -- panel_top_left.SetParams(fx)
  -- self.path.AddSprite(panel_top_left)
  -- self.panel_top_left = panel_top_left

  -- self.panel_left = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- --self.panel_top_left = Sprite()
  -- fx = self.panel_left.GetParams()
  -- fx.SetPos(Vector(0,12))
  -- fx.SetSize(Vector(12,24))
  -- fx.EnableDrawRect(Vector(0, 12, 12, 24)) --crop image
  -- self.panel_left.SetParams(fx)
  -- self.path.AddSprite(self.panel_left)

  -- self.panel_bottom_left = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_bottom_left.GetParams()
  -- fx.SetPos(Vector(0,36))
  -- fx.SetSize(Vector(12,12))
  -- fx.EnableDrawRect(Vector(0, 36, 12, 12)) --crop image
  -- self.panel_bottom_left.SetParams(fx)
  -- self.path.AddSprite(self.panel_bottom_left)

  -- self.panel_top_middle = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_top_middle.GetParams()
  -- fx.SetPos(Vector(12,0))
  -- fx.SetSize(Vector(24,12))
  -- fx.EnableDrawRect(Vector(12, 0, 24, 12)) --crop image
  -- self.panel_top_middle.SetParams(fx)
  -- self.path.AddSprite(self.panel_top_middle)

  -- self.panel_center = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_center.GetParams()
  -- fx.SetPos(Vector(12,12))
  -- fx.SetSize(Vector(24,24))
  -- fx.EnableDrawRect(Vector(12, 12, 24, 24)) --crop image
  -- self.panel_center.SetParams(fx)
  -- self.path.AddSprite(self.panel_center)

  -- self.panel_bottom_middle = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_bottom_middle.GetParams()
  -- fx.SetPos(Vector(12,36))
  -- fx.SetSize(Vector(24,12))
  -- fx.EnableDrawRect(Vector(12, 36, 24, 12)) --crop image
  -- self.panel_bottom_middle.SetParams(fx)
  -- self.path.AddSprite(self.panel_bottom_middle)

  -- self.panel_top_right = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_top_right.GetParams()
  -- fx.SetPos(Vector(36,0))
  -- fx.SetSize(Vector(12,12))
  -- fx.EnableDrawRect(Vector(36, 0, 12, 12)) --crop image
  -- self.panel_top_right.SetParams(fx)
  -- self.path.AddSprite(self.panel_top_right)

  -- self.panel_right = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_right.GetParams()
  -- fx.SetPos(Vector(36,12))
  -- fx.SetSize(Vector(12,24))
  -- fx.EnableDrawRect(Vector(36, 12, 12, 24)) --crop image
  -- self.panel_right.SetParams(fx)
  -- self.path.AddSprite(self.panel_right)

  -- self.panel_bottom_right = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  -- fx = self.panel_bottom_right.GetParams()
  -- fx.SetPos(Vector(36,36))
  -- fx.SetSize(Vector(12,12))
  -- fx.EnableDrawRect(Vector(36, 36, 12, 12)) --crop image
  -- self.panel_bottom_right.SetParams(fx)
  -- self.path.AddSprite(self.panel_bottom_right)

  return self
end

local path = application.GetActivePath()

-- local btn_test = button:new()
-- btn_test:setup(path,0,0,32,32)

-- local btn_test2 = button:new()
-- btn_test2:setup(path,0,64,32,32)
-- btn_test2:func(function()
--   backlog_post("//// button...");
--   btn_test:hide()
-- end)

local panel_test = panel:new()
panel_test:setup(path,0,0,32,32)


runProcess(function()
  backlog_post("/// INIT runProcess FN ///");


  local panel_top_left = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  local fx = panel_top_left.GetParams()
  fx.EnableDrawRect(Vector(0, 0, 24, 24)) --crop image
  -- fx.SetPos(Vector(0,0))
  fx.SetSize(Vector(48,48))
  panel_top_left.SetParams(fx)
  path.AddSprite(panel_top_left)
  --panel_top_left = panel_top_left

  --local panel_bottom_right = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
  local panel_bottom_right = Sprite()
  local fx1 = panel_top_left.GetParams()
  --local fx1 = panel_bottom_right.GetParams()
  fx1.EnableDrawRect(Vector(0, 0, 24, 24)) --crop image
  fx1.SetPos(Vector(0,36))
  fx1.SetSize(Vector(48,48))
  
  --panel_bottom_right.SetParams(fx1)
  panel_bottom_right.SetParams(fx1)

  path.AddSprite(panel_bottom_right)
  --fail to copy texture2d
  



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
    -- btn_test:update()
    -- btn_test2:update()

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      path.RemoveFont(font)
      path.RemoveSprite(sprite_panel)
		end
  end
end)