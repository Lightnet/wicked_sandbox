



local scene = GetScene()
-- from wicked example code character_controller.lua
-- Third person camera controller class:
local function ThirdPersonCamera(character)
	local self = {
		camera = INVALID_ENTITY,
		character = nil,
		side_offset = 0.2,
		rest_distance = 1,
		rest_distance_new = 1,
		min_distance = 0.5,
		zoom_speed = 0.3,
		target_rot_horizontal = 0,
		target_rot_vertical = 0,
		target_height = 1,
		
		Create = function(self, character)
			self.character = character
			
			self.camera = CreateEntity()
			local camera_transform = scene.Component_CreateTransform(self.camera)
		end,
		
		Update = function(self)
			if self.character == nil then
				return
			end

			-- Mouse scroll or gamepad triggers will move the camera distance:
			local scroll = input.GetPointer().GetZ() -- pointer.z is the mouse wheel delta this frame
			scroll = scroll + input.GetAnalog(GAMEPAD_ANALOG_TRIGGER_R).GetX()
			scroll = scroll - input.GetAnalog(GAMEPAD_ANALOG_TRIGGER_L).GetX()
			scroll = scroll * self.zoom_speed
			self.rest_distance_new = math.max(self.rest_distance_new - scroll, self.min_distance) -- do not allow too close using max
			self.rest_distance = math.lerp(self.rest_distance, self.rest_distance_new, 0.1) -- lerp will smooth out the zooming

			-- This will allow some smoothing for certain movements of camera target:
			--local character_transform = scene.Component_GetTransform(self.character.model)
			local character_transform = scene.Component_GetTransform(self.character)
			local character_position = character_transform.GetPosition()
			self.target_rot_horizontal = math.lerp(self.target_rot_horizontal, self.character.target_rot_horizontal, 0.1)
			self.target_rot_vertical = math.lerp(self.target_rot_vertical, self.character.target_rot_vertical, 0.1)
			self.target_height = math.lerp(self.target_height, character_position.GetY() + self.character.target_height, 0.1)

			local camera_transform = scene.Component_GetTransform(self.camera)
			local target_transform = TransformComponent()
			target_transform.Translate(Vector(character_position.GetX(), 0, character_position.GetZ()))
			target_transform.Translate(Vector(0, self.target_height))
			target_transform.Rotate(Vector(self.target_rot_vertical, self.target_rot_horizontal))
			target_transform.UpdateTransform()
			
			-- First calculate the rest orientation (transform) of the camera:
			local mat = matrix.Translation(Vector(self.side_offset, 0, -self.rest_distance))
			mat = matrix.Multiply(mat, target_transform.GetMatrix())
			camera_transform.ClearTransform()
			camera_transform.MatrixTransform(mat)
			camera_transform.UpdateTransform()


			-- Camera collision:

			-- Compute the relation vectors between camera and target:
			local camPos = camera_transform.GetPosition()
			local targetPos = target_transform.GetPosition()
			local camDistance = vector.Subtract(camPos, targetPos).Length()

			-- These will store the closest collision distance and required camera position:
			local bestDistance = camDistance
			local bestPos = camPos
			local camera = GetCamera()

			-- Update global camera matrices for rest position:
			camera.TransformCamera(camera_transform)
			camera.UpdateCamera()

			-- Cast rays from target to clip space points on the camera near plane to avoid clipping through objects:
			local unproj = camera.GetInvViewProjection()	-- camera matrix used to unproject from clip space to world space
			local clip_coords = {
				Vector(0,0,1,1),	-- center
				Vector(-1,-1,1,1),	-- bottom left
				Vector(-1,1,1,1),	-- top left
				Vector(1,-1,1,1),	-- bottom right
				Vector(1,1,1,1),	-- top right
			}
			for i,coord in ipairs(clip_coords) do
				local corner = vector.TransformCoord(coord, unproj)
				local target_to_corner = vector.Subtract(corner, targetPos)
				local corner_to_campos = vector.Subtract(camPos, corner)
				local TMin = 0
				local TMax = target_to_corner.Length() -- optimization: limit the ray tracing distance

				local ray = Ray(targetPos, target_to_corner.Normalize(), TMin, TMax)

				local collision_layer =  ~(Layers.Player | Layers.NPC) -- specifies that neither NPC, nor Player can collide with camera
				local collObj,collPos,collNor = scene.Intersects(ray, FILTER_NAVIGATION_MESH | FILTER_COLLIDER,  collision_layer)
				if(collObj ~= INVALID_ENTITY) then
					-- It hit something, see if it is between the player and camera:
					local collDiff = vector.Subtract(collPos, targetPos)
					local collDist = collDiff.Length()
					if(collDist > 0 and collDist < bestDistance) then
						bestDistance = collDist
						bestPos = vector.Add(collPos, corner_to_campos)
						--DrawPoint(collPos, 0.1, Vector(1,0,0,1))
					end
				end
			end
			
			-- We have the best candidate for new camera position now, so offset the camera with the delta between the old and new camera position:
			local collision_offset = vector.Subtract(bestPos, camPos)
			mat = matrix.Multiply(mat, matrix.Translation(collision_offset))
			camera_transform.ClearTransform()
			camera_transform.MatrixTransform(mat)
			camera_transform.UpdateTransform()
			--DrawPoint(bestPos, 0.1, Vector(1,1,0,1))
			
			-- Feed back camera after collision:
			camera.TransformCamera(camera_transform)
			camera.UpdateCamera()
				
		end,
	}

	self:Create(character)
	return self
end


backlog_post("Begin script: blank.lua");
runProcess(function()
  update()


  local prevPath = application.GetActivePath()
  local path = RenderPath3D()
  application.SetActivePath(path)

  --local loadingscreen = LoadingScreen()
  LoadModel(script_dir() .. "../../scenes/controller_test01.wiscene")
  local player = LoadModel(script_dir() .. "../../scenes/player_base01.wiscene")
  transform_component = scene.Component_GetTransform(player)
  local rest_matrix = transform_component.GetMatrix()

  --local camera = ThirdPersonCamera(player)

  -- local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name
  -- local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  -- GetCamera().TransformCamera(transform)
  
  while true do

    --camera:Update()

    if not backlog_isactive() then
      if input.Press(KEYBOARD_BUTTON_ESCAPE) then
        backlog_post("ESC ", os.time())
        application.SetActivePath(prevPath)
      end
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