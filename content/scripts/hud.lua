--[[
  player head up display
]]
backlog_post("/// INIT test_run.lua ///");

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");

  while true do
    update() --need to call for wicked engine to update snyc.
  end
end)