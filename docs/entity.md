


```lua
scene = GetScene()

LoadModel(script_dir() .. "../cube.wiscene")
cube_entity = scene.Entity_FindByName("cube") -- query the teapot lid object by name
transform_component = scene.Component_GetTransform(cube_entity)
rest_matrix = transform_component.GetMatrix() --save transform data for reset


local lookDir = Vector()
local speed = 0.5
lookDir = lookDir:Add( Vector(0,0,speed) )
transform_component.Translate(lookDir)
```

```lua
local cube_entity = LoadModel(script_dir() .. "../cube.wiscene")
transform_component = scene.Component_GetTransform(cube_entity)
rest_matrix = transform_component.GetMatrix() --save transform data for reset
```

```lua
Vector(0, 0.5, 0)
Vector(1)
Vector()
```

```lua
local cube_entity = LoadModel(script_dir() .. "../cube.wiscene")
transform_component = scene.Component_GetTransform(cube_entity)

local lookDir = Vector()
local speed = 0.5
transform_component.Translate(lookDir)
```