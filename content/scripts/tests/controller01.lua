--[[
  party working for camera zoom.
  direction movement still need work.
]]

local scene = GetScene()
-- from wicked example code character_controller.lua
local function Character(model_entity, start_position, face, controllable, anim_scene)
  local self = {
		model = INVALID_ENTITY,
		target_rot_horizontal = 0,
		target_rot_vertical = 0,
		target_height = 0,
		anims = {},
		anim_amount = 1,
		neck = INVALID_ENTITY,
		head = INVALID_ENTITY,
		left_hand = INVALID_ENTITY,
		right_hand = INVALID_ENTITY,
		left_foot = INVALID_ENTITY,
		right_foot = INVALID_ENTITY,
		left_toes = INVALID_ENTITY,
		right_toes = INVALID_ENTITY,
		face = Vector(0,0,1), -- forward direction (smoothed)
		face_next = Vector(0,0,1), -- forward direction in current frame
		movement_velocity = Vector(),
		velocity = Vector(),
		savedPointerPos = Vector(),
		walk_speed = 0.1,
		jog_speed = 0.2,
		run_speed = 0.4,
		jump_speed = 8,
		swim_speed = 0.5,
		layerMask = ~0, -- layerMask will be used to filter collisions
		scale = Vector(1, 1, 1),
		rotation = Vector(0,math.pi,0),
		start_position = Vector(0, 1, 0),
		position = Vector(),
		controllable = true,
		fixed_update_remain = 0,
		timestep_occured = false,
		root_bone_offset = 0,
		foot_placed_left = false,
		foot_placed_right = false,
		--mood = Mood.Neutral,
		mood_amount = 1,
		expression = INVALID_ENTITY,

		pathquery = PathQuery(),
		patrol_waypoints = {},
		patrol_next = 0,
		patrol_wait = 0,
		patrol_reached = false,
		hired = nil,
		dialogs = {},
		next_dialog = 1,
    --Create = function(self, model_entity, start_position, face, controllable)
    Create = function(self, model_entity)

      self.model = model_entity
    end,
    Jump = function(self,f)
      self.velocity.SetY(f)
      self.state = States.JUMP
    end,
    MoveDirection = function(self,dir)
      -- local rotation_matrix = matrix.Multiply(matrix.RotationY(self.target_rot_horizontal), matrix.RotationX(self.target_rot_vertical))
			-- dir = vector.Transform(dir.Normalize(), rotation_matrix)
			-- dir.SetY(0)
			-- local dot = vector.Dot(self.face, dir)
			-- if(dot < 0) then
			-- 	self.face = vector.TransformNormal(self.face, matrix.RotationY(math.pi * 0.01)) -- Turn around 180 degrees easily when wanting to go backwards
			-- end
			-- self.face_next = dir
			-- self.face_next = self.face_next.Normalize()
			-- if(dot > 0) then 
			-- 	local speed = 0
			-- 	if self.state == States.WALK then
			-- 		speed = self.walk_speed
			-- 	elseif self.state == States.JOG then
			-- 		speed = self.jog_speed
			-- 	elseif self.state == States.RUN then
			-- 		speed = self.run_speed
			-- 	elseif self.state == States.SWIM then
			-- 		speed = self.swim_speed
			-- 	end
			-- 	self.movement_velocity = self.face:Multiply(Vector(speed,speed,speed))
			-- end
    end,
    Update = function(self)
      local dt = getDeltaTime()
    end,
    Update_IK = function(self)
    end,
    Update_Footprints = function(self)
    end,
    Follow = function(self, leader)
      self.hired = leader
    end,
    Unfollow = function(self)
      self.hired = nil
      self.patrol_waypoints = {}
    end
  }
  --self:Create(model_entity, start_position, face, controllable)
  self:Create(model_entity)
	return self
end


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
			local character_transform = scene.Component_GetTransform(self.character.model)
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

				-- local collision_layer =  ~(Layers.Player | Layers.NPC) -- specifies that neither NPC, nor Player can collide with camera
				-- local collObj,collPos,collNor = scene.Intersects(ray, FILTER_NAVIGATION_MESH | FILTER_COLLIDER,  collision_layer)
				-- if(collObj ~= INVALID_ENTITY) then
				-- 	-- It hit something, see if it is between the player and camera:
				-- 	local collDiff = vector.Subtract(collPos, targetPos)
				-- 	local collDist = collDiff.Length()
				-- 	if(collDist > 0 and collDist < bestDistance) then
				-- 		bestDistance = collDist
				-- 		bestPos = vector.Add(collPos, corner_to_campos)
				-- 		--DrawPoint(collPos, 0.1, Vector(1,0,0,1))
				-- 	end
				-- end
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
  local character = LoadModel(script_dir() .. "../../scenes/player_base01.wiscene")

  local player = Character(character)

  --local transform_component = scene.Component_GetTransform(character)
  --local rest_matrix = transform_component.GetMatrix()

  local camera = ThirdPersonCamera(player)

  -- local cam_entity = scene.Entity_FindByName("camera") -- query the camera object by name
  -- local transform = scene.Component_GetTransform(cam_entity) -- get camera's transform
  -- GetCamera().TransformCamera(transform)
  
  while true do

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
        local transform_component = scene.Component_GetTransform(character)
        transform_component.Translate(lookDir)
      end
    end

    camera:Update()

    update()
  end
end)

backlog_post("Script complete.");