

```lua
local path = application.GetActivePath()--render path

local sprite_panel = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
local fx = sprite_panel.GetParams()
fx.SetPos(Vector(0,0))
fx.SetSize(Vector(64,64))
--backlog_post("fx.GetSize: ", fx.GetSize());--by default zero
sprite_panel.SetParams(fx)
path.AddSprite(sprite_panel)
--path.RemoveSprite(sprite_panel)
```

```lua
sprite_panel = Sprite(script_dir() .. "../ui/kenney_fantasy-ui-borders/PNG/Default/Panel/panel-000.png")
--local params = ImageParams(0,0,64,64)
--sprite_button.SetParams(params)
local fx = sprite_panel.GetParams()
fx.SetPos(Vector(0,0))
fx.EnableDrawRect(Vector(0, 0, 16, 16))
fx.SetSize(Vector(128,128))
fx.SetColor(Vector(0,1,0.5,1))
sprite_panel.SetParams(fx)
path.AddSprite(sprite_panel) -- 1 texture image

local sprite2 = Sprite() --create empty sprite
fx = sprite_panel.GetParams() --copy sprite
fx.SetPos(Vector(0,200))
fx.EnableDrawRect(Vector(0, 0, 16, 16))
fx.SetSize(Vector(128,128))
fx.SetColor(Vector(0,1,0.5,1))
sprite2.SetParams(fx) --set sprite data
path.AddSprite(sprite2) -- 2 texture image
```