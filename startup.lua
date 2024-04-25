
--killProcesses()

runProcess(function()
  -- Wait for Engine update tick
  update()--this is need to update 
  dofile(script_dir() .. "game.lua")
end)
