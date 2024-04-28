https://discord.com/channels/602811659224088577/761247954942033991/1231925349680414801

# [Wicked Engine] Standalone build, switching to Vulkan:
 - https://www.youtube.com/watch?v=YNYCGlistBE&list=PLLN-1FTGyLU_HJoC5zx6hJkB3D2XLiaxS&index=27

# Wicked Engine - Creating an Application:
 - https://www.youtube.com/watch?v=uhbkB07iaC0&list=PLLN-1FTGyLU_HJoC5zx6hJkB3D2XLiaxS&index=97
```
Configuration properties:
-Linker
--input
---additional depednecies
----wickedengine_windows.lib
---evaluated value
----wickedengine_windows.lib
----%(AdditionalDependnes)
```
 wrong?


# Template_Windows Default:
```
-Template_Windows.exe
-shaders
```
It need shader to load app.
```
wicked_engine\Template_Windows\shaders
```

# Template_Windows embbed:
OfflineShaderCompiler
```
Deubgging:
-Command Arguments
--hlsl6 spirv shaderdump
```
