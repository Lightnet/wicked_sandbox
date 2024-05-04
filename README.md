# Project Name: Wicked Sandbox

# License: MIT

# Created By: Lightnet

# Status:
 * prototyping scripts

# Program:
 - Wicked Engine v0.71.422
 - vscode

# Code Language:
 * Lua

# Information:
  To create game test on Wicked Engine. To develop and prototype lua scripting, prefab scenes and entities.

  To build minecraft theme block world. To create block and delete scene build test.

# Assets file:
  If you use Godot Engine. It has it node tree components types. It save it own format for engine to save, edit and load scene. Like unity, unreal engine and other for game engine that easy to read and load into the world engine.

  The Wicked Engine Editor can create entity, components and script is save to file for engine to load. It depend what type of entity is scene, character, map and so on.
```
'filename'.wiscene
```
  The file extension wiscene is stand alone assets as does not link to other files in the assets. The reason is that Wicked engine convert it to wiscene for engine to load quickly.
 
 Once the script is load into into the component does not load from path but in 'filename'.wiscene. After testing it. It does not update the changes.


# Layout:
```
-project folder
--libraries <- file.dll?
--Editor_Windows.exe
--config.ini
--startup.lua - default entry
--content
---models
---scripts
```

# Features /  Do list:
 - Tests
   - [ ] HUD
   - [ ] controller
   - [ ] ui package
   - [ ] physics
   - [ ] raycast blocks
   - [ ] create object
 - [ ] create player
 - [ ] ui menu
 - [ ] blocks


# Set Up Window:
  * https://github.com/turanszkij/WickedEngine

  Download binary or Steam store.

# Links:
 * https://github.com/turanszkij/WickedEngine

# Credits:
 * https://kenney.nl/assets
   * ui
   * sound
   * 3d model

 Assets files are on are free. Note there will be mixed with other files.