--template
backlog_post("/// INIT test_script.lua ///");

runProcess(function()
  backlog_post("/// INIT runProcess FN ///");

  while true do
    update() --need to call for wicked engine to update snyc.
  end
end)
