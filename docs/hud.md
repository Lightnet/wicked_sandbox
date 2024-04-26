
# HUD Information:
  Note lua does not have UI.

# Design:

```
  sprite
  path render


  -create
  -panel 9 sprite rect
  -

  -destroy

```

# Test builds:

```lua
local path = application.GetActivePath()

sprite_button = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
local fx = sprite_button.GetParams()
fx.SetPos(Vector(0,0))
backlog_post("fx.GetSize: ", fx.GetSize());
sprite_button.SetParams(fx)
path.AddSprite(sprite_button)
```
Result of width and height is zero.
```lua
local path = application.GetActivePath()
sprite_button = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
local params = ImageParams(0,0,64,64)
sprite_button.SetParams(params)
path.AddSprite(sprite_button)
```
  works!

```lua
local path = application.GetActivePath()
sprite_button = Sprite(script_dir() .. "../ui/kenney_ui-pack/blue_button07.png")
local fx = sprite_button.GetParams()
fx.SetPos(Vector(0,0))
fx.SetSize(Vector(64,64))
--backlog_post("fx.GetSize: ", fx.GetSize());
sprite_button.SetParams(fx)
path.AddSprite(sprite_button)

```
  works!


https://discord.com/channels/602811659224088577/602811659224088583/1146619635219832975
```lua
local ls = LoadingScreen()

local font = SpriteFont()
font.SetText("Loading...")
font.SetSize(40)
local ts = font.TextSize()
font.SetPos(Vector(
  application.GetCanvas().GetLogicalWidth() * .5 - ts.X * .5,
  application.GetCanvas().GetLogicalHeight() * .5 - ts.Y * .5
))
ls.AddFont(font)

ls:AddLoadingTask("preload.lua")
ls:OnFinished("Wicked/Content/scripts/character_controller/character_controller.lua")

application.SetActivePath(ls)


--dofile("Wicked/Content/scripts/character_controller/character_controller.lua")
```


https://discord.com/channels/602811659224088577/602811659224088583/1212068443667570709

```
turanszkij: You can use Sprite and SpriteFont classes from lua to make simple UI, fighting_game.lua sample also does that for the health bars. The real gui library (wi::gui::Button, etc) doesn't have lua bindings now
```




https://discord.com/channels/602811659224088577/602811659224088583/1212279859108388934

```lua
-- sprite and font adding, removing:
renderpath.AddSprite(sprite)
renderpath.AddFont(font)
renderpath.RemoveSprite(sprite)
renderpath.RemoveFont(font)
-- font also has this:
font.SetHidden(true)
-- input check examples:
input.Press(KEYBOARD_BUTTON_UP) -- check if button was pressed once
input.Down(KEYBOARD_BUTTON_UP) -- check if button is held down currently
mouse = input.GetPointer() -- returns Vector that has mouse pointer coordinates in XY, and mouse wheel scrolling value in Z and pen pressure in W component
```