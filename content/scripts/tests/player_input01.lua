
backlog_post("Begin script: player_input.lua");

scene = GetScene()

runProcess(function()
  backlog_post("init...");
  update()
  LoadModel(script_dir() .. "../scenes/cube.wiscene")

  cube_entity = scene.Entity_FindByName("cube") -- query the teapot lid object by name
  transform_component = scene.Component_GetTransform(cube_entity)
  rest_matrix = transform_component.GetMatrix()

  while true do

    if not backlog_isactive() then
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
      end

      if input.Press(string.byte('A')) then
        backlog_post("A")
        transform_component.Translate(Vector(0, 0.5, 0))
      end
      -- if input.Press(string.byte('S')) then
      --   backlog_post("S")
      -- end
      if input.Press(string.byte('D')) then
        backlog_post("D")
        transform_component.Translate(Vector(0, -0.5, 0))
      end
      -- if input.Press(string.byte('W')) then
      --   backlog_post("W")
      -- end
    end
    update()
  end
end)

backlog_post("Script complete.");