

 - https://github.com/turanszkij/WickedEngine/blob/master/features.txt

#  Wicked engine lua features disable:
 - print

 require > dofile

foo.lua
```
test = "Test" --global var
```

main.lua
```
dofile 'content/scripts/foo.lua'
backlog_post("///test: ",test); --from loaded variable
```



# Lua Scripting guide:

  This guide help understand how lua and wicked engine works.

  Scripting in Wicked Engine is easy and hard depend on which area you doing. You can run on one script to run the game.

  Why need lua scripting it simple as it does not need to compile for binary. But another topic if compile into binary.

  You check on lua wiki for quick learning about it. As well other sites give out general informtion how it works.

  https://en.wikipedia.org/wiki/Lua_(programming_language)

  Lua is small file for good for embed technologies and small print on file size. Like python programing language the file size for just python is +25 mb that depened on the package module.
  
  The Wicked Engine is Entity Component System. You can think of Godot Engine and gd script python style. As well like javascript script as simalar way to create the engine or framework. Example three.js. There is bevy engine in rust language for application build.
  
  Wicked Engine more bare bone ui minimal and configure. One reason user can create their own code. Have not work on UI design yet. There are default config for scene, graphics and other things. As well example files in Wicked Engine content folder.

  Lua Program Language structure is base on table. 

```lua
local mytable = {} --table
function mytable:foo() --function
  print("bar")
end
--another method
mytable:foo = function() --function
  print("bar")
end
```
  
  You can think of javascript or python class for different way handle the set up. 
  
  But with the Wicked Engine api call and setup. 

  The next is the lua pathing file. Since it important to talk about. It about the how it handle file paths dirs. Current from I know it start where the current run location. If you wish to go up directory folder and it will not understand. As well bad practice.

  By default. https://www.lua.org/pil/8.1.html
```
?;?.lua;
```

main.lua
```
package.path = package.path .. ";../?.lua" --append file path
```

Note for requires in (project root) will look up files outside of project root, which is not desirable. By default it will try to look up vary degree pathing array.

One of the reason is mobile devices can't do that without permission of the user and must follow standrard OS format application data storage format.

If you notice that there is global variable and function predefine by Wicked Engine and Lua API.

To run simple script is easy as lanuch the window editor.

Open the text editor, name and save it on project root dir.


print_text.lua
```
backlog_post("/////////////////////////////////////");
backlog_post("///",os.time());
backlog_post("/////////////////////////////////////");
```

Open the editor. Open the file and select the print_text.lua as it will automate run script. Use Home Key to console log view it.

If you notice that there is no print() since it remove or config for Wicked engine different log call.

You can look up the Lua script doc in wicked engine github.

The next part is tricky and not sure of standard format. But there are area need to look at.


test_run.lua
```
backlog_post("/// INIT test_run.lua ///");
--setup for normal lua
--depend on the api here it will be call or not.
runProcess(function()
  backlog_post("/// INIT runProcess FN ///");
  --this need for Wicked API that for run script.
  --there docs found in wicked engine doc on github
  --setup scene
  --setup model load
  --run loop
  while true do
    -- this will print logs
    backlog_post("///",os.time());
    update() --need to call for wicked engine to update snyc.
    --input call here
    --render
  end
  --clean up?
  --backlog_post("/// CLEAN UP ///");--does not show up in logs
end)
```
  The area where the script is lanuch in order. The setup and runProcess to run the script if there entity scene need to loop run.



  
   
https://www.reddit.com/r/lua/comments/wi0bau/whats_the_correct_way_to_run_a_lua_file_that_uses/

