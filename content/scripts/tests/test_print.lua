
backlog_post("Begin script: test_print.lua");
print("hello print")

runProcess(function()
  print("hello world...")
end)

backlog_post("Script complete.");