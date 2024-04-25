
backlog_post("Begin script: test_camera.lua");
print("hello print")

runProcess(function()
  --print("hello world...")
  --backlog_post("hello world");
  backlog_post(os.time());
end)

backlog_post("Script complete.");