backlog_post("Begin script: blank.lua");
runProcess(function()
  --backlog_post("blank");
  --backlog_post(os.time());
  --update()
  while true do
    backlog_post("/// ", os.time());
    update() --need to call for wicked engine to update snyc.
  end


end)

backlog_post("Script complete.");