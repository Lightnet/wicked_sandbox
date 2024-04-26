

```lua
runProcess(function()


  while true do
    update()

    local mouse = input.GetPointer()
    backlog_post("/// POS: ", mouse.X, ": ", mouse.Y);

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
    
    if input.Press( MOUSE_BUTTON_LEFT ) then
      backlog_post("MOUSE_BUTTON_LEFT")
    end


  end

end)
```