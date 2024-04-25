print("main hello world")
-- Set a rendering path for the application
-- path = RenderPath3D;
-- application.SetActivePath(path);    -- "application" is created automatically by wi::Application

-- Load a model entity into the global scene:
-- entity = LoadModel("myModel.wiscene");

-- Load a model entity into a separate scene:
scene2 = Scene()
-- entity2 = LoadModel(scene2, "myModel2.wiscene");

-- Combine the separate scene with the global scene:
--scene.Merge(scene2);

-- Get the current global scene:
scene = GetScene();

-- Move model to the right using the entity-component system:
-- transform = scene.Component_GetTransform(entity);
-- transform.Translate(Vector(2, 0, 0));

-- Print any WickedEngine class information to the backlog:
getprops(application);	-- prints the application methods
getprops(scene);	-- prints the Scene class methods
getprops(path);	-- prints the deferred render path methods

-- Play a sound:
-- sound = Sound()
-- audio.CreateSound("explosion.wav", sound)
-- soundinstance = SoundInstance()
-- audio.CreateSoundInstance(sound, soundinstance)  -- several instances can be created from one file
-- audio.Play(soundinstance)
-- audio.SetVolume(0.6, soundinstance)  -- sets the volume of this soundinstance
-- audio.SetVolume(0.2)  -- sets the master volume

-- Check for input:
if(input.Press(KEYBOARD_BUTTON_LEFT)) then
  --audio.Play(soundinstance); -- this will play the sound if you press the left arrow on the keyboard
  print("LEFT")
end