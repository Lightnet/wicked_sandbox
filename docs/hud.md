
# HUD Information:
  Note lua does not have UI. c/c++ has ui.






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