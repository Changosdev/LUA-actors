local p
do
  local _obj_0 = require("moon")
  p = _obj_0.p
end
local Scheduler
do
  local _obj_0 = require("scheduler")
  Scheduler = _obj_0.Scheduler
end
local scheduler = Scheduler()
local counter = scheduler:spawn('TCounter', { })
return scheduler:run()
