

```lua
runProcess(function()
  backlog_post('KEYBOARD_BUTTON_ESCAPE')
  backlog_post(KEYBOARD_BUTTON_ESCAPE)
  while true do

    update()
    if(not backlog_isactive() and input.Press(KEYBOARD_BUTTON_ESCAPE)) then
      backlog_post("ESC ", os.time())
    end

    if(not backlog_isactive() and input.Press(string.byte('R'))) then
      backlog_post("R ",os.time())
    end
  end
end)
```