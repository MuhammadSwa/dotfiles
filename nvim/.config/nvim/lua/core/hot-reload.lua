local status_ok, hot_reload = pcall(require, "hot-reload")
if not status_ok then
  print("Problem with hot-reload")
  return
end

hot_reload.setup({})
