
```lua
Vector(0, 0.5, 0)
Vector(1)
Vector()
```

```lua

local scene = GetScene()
local path = application.GetActivePath()

local camera_entity = CreateEntity()
scene.Component_CreateName(camera_entity).SetName("camera")
scene.Component_CreateTransform(camera_entity)
scene.Component_CreateCamera(camera_entity)
```




```lua
scene = GetScene()

LoadModel(script_dir() .. "../cube.wiscene")
cube_entity = scene.Entity_FindByName("cube") -- query the object by name
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
local cube_entity = LoadModel(script_dir() .. "../cube.wiscene")
transform_component = scene.Component_GetTransform(cube_entity)

local lookDir = Vector()
local speed = 0.5
transform_component.Translate(lookDir)
```