
```lua
local prevPath = application.GetActivePath()
--local path = RenderPath3D()
--application.SetActivePath(path)
local path = prevPath

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
```