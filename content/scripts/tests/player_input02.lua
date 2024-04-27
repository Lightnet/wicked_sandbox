
backlog_post("Begin script: player_input.lua");

scene = GetScene()

runProcess(function()
  backlog_post("init...");
  update()
  LoadModel(script_dir() .. "../cube.wiscene")

  cube_entity = scene.Entity_FindByName("cube") -- query the teapot lid object by name
  transform_component = scene.Component_GetTransform(cube_entity)
  rest_matrix = transform_component.GetMatrix()

  while true do

    if not backlog_isactive() then
      local lookDir = Vector()--line 566 character_controller.lua
      local speed = 0.5
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
      end
      
      if input.Down(string.byte('A')) then
        backlog_post("A")
        lookDir = lookDir:Add( Vector(-speed) )
      end
      if input.Down(string.byte('D')) then
        backlog_post("D")
        lookDir = lookDir:Add( Vector(speed) )
      end
      if input.Down(string.byte('S')) then
        backlog_post("S")
        lookDir = lookDir:Add( Vector(0,0,-speed) )
      end
      if input.Down(string.byte('W')) then
        backlog_post("W")
        lookDir = lookDir:Add( Vector(0,0,speed) )
      end
      if(lookDir.Length() > 0) then
        --451 line
        transform_component.Translate(lookDir)
      end
    end
    update()
  end
end)

backlog_post("Script complete.");