--[[
  script component trigger once.

  when load mode into the scene. The settings script need to check to trigger once.

]]
backlog_post("Begin script: script_com_once.lua");
runProcess(function()
  --backlog_post("script_com_once");
  --backlog_post(os.time());
  --update()
  while true do
    backlog_post("/// ", os.time());
    update() --need to call for wicked engine to update snyc.
  end


end)

backlog_post("Script complete.");