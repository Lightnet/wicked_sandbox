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