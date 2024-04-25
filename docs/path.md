

foo.lua
```lua
test = "Test" --global var
local bar = "testme" --current to this script
--backlog_post(bar);
return bar -- export
```

startup.lua
```lua
package.path = "./content/scripts/?.lua;" .. package.path
--local foo = require './content/scripts/foo'
local foo = require 'content/scripts/foo'
backlog_post("///foo: ",foo);--export variable
backlog_post("///test: ",test);--global variable
```